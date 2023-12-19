package terraformutils

import (
	"log"
	"math/rand"
	"reflect"
	"strings"
	"time"

	"github.com/GoogleCloudPlatform/terraformer/terraformutils/providerwrapper"
)

type ProvidersMapping struct {
	baseProvider       ProviderGenerator
	Resources          map[*Resource]bool
	Services           map[string]bool
	Providers          map[ProviderGenerator]bool
	providerToService  map[ProviderGenerator]string
	serviceToProvider  map[string]ProviderGenerator
	resourceToProvider map[*Resource]ProviderGenerator
}

func NewProvidersMapping(baseProvider ProviderGenerator) *ProvidersMapping {
	providersMapping := &ProvidersMapping{
		baseProvider:       baseProvider,
		Resources:          map[*Resource]bool{},
		Services:           map[string]bool{},
		Providers:          map[ProviderGenerator]bool{},
		providerToService:  map[ProviderGenerator]string{},
		serviceToProvider:  map[string]ProviderGenerator{},
		resourceToProvider: map[*Resource]ProviderGenerator{},
	}

	return providersMapping
}

func deepCopyProvider(provider ProviderGenerator) ProviderGenerator {
	return reflect.New(reflect.ValueOf(provider).Elem().Type()).Interface().(ProviderGenerator)
}

func (p *ProvidersMapping) GetBaseProvider() ProviderGenerator {
	return p.baseProvider
}

func (p *ProvidersMapping) AddServiceToProvider(service string) ProviderGenerator {
	newProvider := deepCopyProvider(p.baseProvider)
	p.Providers[newProvider] = true
	p.Services[service] = true
	p.providerToService[newProvider] = service
	p.serviceToProvider[service] = newProvider

	return newProvider
}

func (p *ProvidersMapping) GetServices() []string {
	services := make([]string, len(p.Services))
	for service := range p.Services {
		services = append(services, service)
	}

	return services
}

func (p *ProvidersMapping) RemoveServices(services []string) {
	for _, service := range services {
		delete(p.Services, service)

		matchingProvider := p.serviceToProvider[service]
		delete(p.Providers, matchingProvider)
		delete(p.providerToService, matchingProvider)
		delete(p.serviceToProvider, service)
	}
}

func (p *ProvidersMapping) ShuffleResources() []*Resource {
	resources := []*Resource{}
	for resource := range p.Resources {
		resources = append(resources, resource)
	}
	rand.Seed(time.Now().UnixNano())
	rand.Shuffle(len(resources), func(i, j int) { resources[i], resources[j] = resources[j], resources[i] })

	return resources
}

func (p *ProvidersMapping) ProcessResources(isCleanup bool) {
	initialResources := p.resourceToProvider
	if isCleanup && len(initialResources) > 0 {
		p.Resources = map[*Resource]bool{}
		p.resourceToProvider = map[*Resource]ProviderGenerator{}
		for provider := range p.Providers {
			resources := provider.GetService().GetResources()
			log.Printf("Filtered number of resources for service %s: %d", p.providerToService[provider], len(provider.GetService().GetResources()))
			for i := range resources {
				resource := resources[i]
				p.Resources[&resource] = true
				p.resourceToProvider[&resource] = provider
			}
		}
	} else if !isCleanup {
		for provider := range p.Providers {
			resources := provider.GetService().GetResources()
			log.Printf("Number of resources for service %s: %d", p.providerToService[provider], len(provider.GetService().GetResources()))
			for i := range resources {
				resource := resources[i]
				p.Resources[&resource] = true
				p.resourceToProvider[&resource] = provider
			}
		}
	}
}

func (p *ProvidersMapping) MatchProvider(resource *Resource) ProviderGenerator {
	return p.resourceToProvider[resource]
}

func (p *ProvidersMapping) SetResources(resourceToKeep []*Resource) {
	p.Resources = map[*Resource]bool{}
	resourcesGroupsByProviders := map[ProviderGenerator][]Resource{}
	for i := range resourceToKeep {
		resource := resourceToKeep[i]
		provider := p.resourceToProvider[resource]
		if resourcesGroupsByProviders[provider] == nil {
			resourcesGroupsByProviders[provider] = []Resource{}
		}
		//log.Printf("resources %v\n", *resource)
		resourcesGroupsByProviders[provider] = append(resourcesGroupsByProviders[provider], *resource)
		p.Resources[resource] = true
	}

	for provider := range p.Providers {
		provider.GetService().SetResources(resourcesGroupsByProviders[provider])
	}
}

func (p *ProvidersMapping) GetResourcesByService() map[string][]Resource {
	mapping := map[string][]Resource{}
	for service := range p.Services {
		mapping[service] = []Resource{}
	}

	for resource := range p.Resources {
		provider := p.resourceToProvider[resource]
		service := p.providerToService[provider]
		mapping[service] = append(mapping[service], *resource)
	}

	return mapping
}
func containsAny(arr []string, target string) bool {
	for _, str := range arr {
		if str == target {
			return true
		}
	}
	return false
}

func containsString(target, occur string) bool {
	return strings.Contains(target, occur)
}

func (p *ProvidersMapping) ConvertTFStates(providerWrapper *providerwrapper.ProviderWrapper, options map[string]interface{}) {
	var filter string
	filter_array, ok := options["Filter"].([]string)
	if ok {
		filter_str := filter_array[0]
		filter = filter_str[4:]
	}
	arr := options["Resources"].([]string)
	var ans []Resource
	if containsString(filter_array[0], "vpc") && (len(arr) > 1) {
	OuterLoop:
		for resource := range p.Resources {
			//log.Printf("  %v\n", resource.InstanceState.Attributes["vpc_id"])
			//arr contains the array of resources like vpc, subnet, igw, nat
			arr := options["Resources"]
			var values []string
			// Check if the value is a slice of strings
			if values, ok := arr.([]string); ok {
				// It is a slice of strings
				log.Printf("values %v\n", values)
			} else {
				// It's not a slice of strings
				log.Printf("Not a slice of strings")
			}
			targets := []string{"vpc", "igw", "subnet", "route_table", "nat"}
			//secondset := []string{"eip","nat"}
			for _, val := range targets {
				if containsAny(values, val) {
					log.Printf("inside if")
					filter_array, ok := options["Filter"].([]string)
					if ok {
						filter_str := filter_array[0]
						filter = filter_str[4:]
						var vpc_id string
						log.Printf("len of ans is %v\n%v\n", len(ans), ans)
						if val == "vpc" {
							vpc_id = resource.InstanceState.ID
						} else if val != "nat" {
							vpc_id = resource.InstanceState.Attributes["vpc_id"]
						} else if val == "nat" {
							log.Printf("nat equal")
							for _, t := range ans {
								if t.InstanceInfo.Type == "subnet" {
									log.Printf("subnet equal")
									if resource.InstanceState.Attributes["subnet_id"] == t.InstanceInfo.Id {
										log.Printf("nat found")
										ans = append(ans, *resource)
										err := resource.ConvertTFstate(providerWrapper)
										if err != nil {
											log.Printf("failed to convert resources %s because of error %s", resource.InstanceInfo.Id, err)
										}
									}
								}
							}
						}
						if vpc_id == filter {
							ans = append(ans, *resource)
							err := resource.ConvertTFstate(providerWrapper)
							if err != nil {
								log.Printf("failed to convert resources %s because of error %s", resource.InstanceInfo.Id, err)
							}
						}
					} else {
						continue OuterLoop
					}
				} else {
					err := resource.ConvertTFstate(providerWrapper)
					if err != nil {
						log.Printf("failed to convert resources %s because of error %s", resource.InstanceInfo.Id, err)
					}

				}
			}
		}
		/*for s := range p.Resources {
			for _, i := range ans {
				log.Printf("aaaaaaaaa s %v\n%v\n", s.InstanceInfo.Type, i.InstanceInfo.Type)
				if (s.InstanceInfo.Type == "nat" && (i.InstanceInfo.Type == "subnet")) {
					if s.InstanceState.Attributes["subnet_id"] == i.InstanceInfo.Id {
						log.Printf("act_resources s %v\n", *s)
						ans = append(ans, *s)
						err := s.ConvertTFstate(providerWrapper)
				if err != nil {
					log.Printf("failed to convert resources %s because of error %s", s.InstanceInfo.Id, err)
				}
					}

				}
			}
		}  */
		resourcesGroupsByProviders := map[ProviderGenerator][]Resource{}
		for resource := range p.Resources {
			if resource.InstanceState.Attributes["vpc_id"] == filter {
				ans = append(ans, *resource)
				provider := p.resourceToProvider[resource]
				if resourcesGroupsByProviders[provider] == nil {
					resourcesGroupsByProviders[provider] = []Resource{}
				}
				resourcesGroupsByProviders[provider] = append(resourcesGroupsByProviders[provider], *resource)
			} else if resource.InstanceState.ID == filter {
				ans = append(ans, *resource)
				provider := p.resourceToProvider[resource]
				if resourcesGroupsByProviders[provider] == nil {
					resourcesGroupsByProviders[provider] = []Resource{}
				}
				resourcesGroupsByProviders[provider] = append(resourcesGroupsByProviders[provider], *resource)
			}
		} 
		for resource := range p.Resources {
			if resource.InstanceInfo.Type == "aws_nat_gateway" {
				log.Printf("else inside")
				for _, j := range ans {
					if j.InstanceInfo.Type == "aws_subnet" {
						log.Printf("inside if")
						log.Printf("id %v", j.InstanceInfo.Id)
						log.Printf("sunet id %v\n", resource.InstanceState.Attributes["subnet_id"])
						val := j.InstanceInfo.Id 
						if strings.Contains(val,resource.InstanceState.Attributes["subnet_id"]) {
							log.Printf("match")
							provider := p.resourceToProvider[resource]
							if resourcesGroupsByProviders[provider] == nil {
								resourcesGroupsByProviders[provider] = []Resource{}
							}
							resourcesGroupsByProviders[provider] = append(resourcesGroupsByProviders[provider], *resource)
						}
					}
				}
			}
		}
		for provider := range p.Providers {
			provider.GetService().SetResources(resourcesGroupsByProviders[provider])
		}
	} else {
		log.Printf("normal flow")
		for resource := range p.Resources {
			//log.Printf(" nat resources test  %v\n", *resource)
			//log.Printf(" vpc  %v\n", resource.InstanceState.Attributes["vpc_id"])
			err := resource.ConvertTFstate(providerWrapper)
			if err != nil {
				log.Printf("failed to convert resources %s because of error %s", resource.InstanceInfo.Id, err)
			}

		}
		resourcesGroupsByProviders := map[ProviderGenerator][]Resource{}
		for resource := range p.Resources {
			provider := p.resourceToProvider[resource]
			if resourcesGroupsByProviders[provider] == nil {
				resourcesGroupsByProviders[provider] = []Resource{}
			}
			resourcesGroupsByProviders[provider] = append(resourcesGroupsByProviders[provider], *resource)
		}

		for provider := range p.Providers {
			provider.GetService().SetResources(resourcesGroupsByProviders[provider])
		}
	}

}

func (p *ProvidersMapping) CleanupProviders() {
	for provider := range p.Providers {
		provider.GetService().PostRefreshCleanup()
		err := provider.GetService().PostConvertHook()
		if err != nil {
			log.Printf("failed run PostConvertHook because of error %s", err)
		}
	}
	p.ProcessResources(true)
}
