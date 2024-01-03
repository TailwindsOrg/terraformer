package terraformutils

import (
	"errors"
	"fmt"
	"log"
	"regexp"
	"strings"
)

const RESOURCEPATTERN = `resource "([^"]+)" "([^"]+)" {`
const MODULEDATAPATTERN = `(\w+)\s* {`
const DATAPATTERN = `(\w+)\s*=\s*"([^"]*)"`
const SUBDATAPATTERN = `(\w+)\s*=\s*{`

func GenerateDynamicVariableForResource(tfByte []byte) ([]byte, error) {
	tfString := string(tfByte)
	lines := strings.Split(tfString, "\n")
	for _, line := range lines {
		resPat, _ := regexp.Compile(RESOURCEPATTERN)
		resMatch := resPat.MatchString(line)
			if resMatch {
				return GenerateDynamicVariableSet(tfByte)
			} else {
				return tfByte,errors.New("not a Resource Module")
			}
	}
	return tfByte,errors.New("not a Valid Module")
}
func GenerateDynamicVariableSet(tfByte []byte) ([]byte, error) {
	
	tfString := string(tfByte)
	lines := strings.Split(tfString, "\n")
	var resourceName string
	var subData string
	var varDeclarations string
	var appendStrings string
	proceed := false
	for _, line := range lines {
		var dataName string
		/*fmt.Println("Line: "+line)
		fmt.Println("RES: "+resourceName)*/

		// Skip empty lines
		if strings.TrimSpace(line) == "" || strings.TrimSpace(line) == "{" || strings.TrimSpace(line) == "}" {
			//fmt.Printf("Skipping: %#v\n", line)
			//continue
			proceed = false
		} else {
			proceed = true
		}

		if strings.TrimSpace(line) == "}" {
			subData = ""
		}
		if proceed {
			resPat, _ := regexp.Compile(RESOURCEPATTERN)
			moduleDataPat, _ := regexp.Compile(MODULEDATAPATTERN)
			dataPat, _ := regexp.Compile(DATAPATTERN)
			subdataPat, _ := regexp.Compile(SUBDATAPATTERN)

			resMatch := resPat.MatchString(line)
			moduleDataMatch  := moduleDataPat.MatchString(line)
			dataMatch  := dataPat.MatchString(line)
			subDataMatch:= subdataPat.MatchString(line)
			if resMatch {
				appendStrings += line+"\n"
				resourceName = ""
				//we are in resources line
				resourceName = dynamicResVariableNameFormation(line)
				if len(resourceName) == 0 {
					log.Println("resourceName formation error")
					//mostly this if is not possible to arise
					continue
				}
				//fmt.Println("Skipping Append in resource line: " + line)
			} else if (dataMatch || subDataMatch || moduleDataMatch) && len(resourceName) > 0 {
				//now not in data key value pair line
				//fmt.Println("inside Sub data matching")
				dataKey, dataVal := dynamicDataVariableNameFormation(line)
				if subDataMatch {
					subData = ""
					//sample subDataMatch
					//tags_all = {
					/*fmt.Printf("dataKeyLine:%v\n",line)
					fmt.Printf("dataKey:%v\n",dataKey)*/
					parts := strings.Split(dataKey, "=")
					if len(parts) == 2 {
						dataKey = strings.TrimSpace(parts[0]) // Trim spaces from the key
					}
					subData = "__" + dataKey
					//resourceName = resourceName+"_"+subData
					appendStrings += line+"\n"
					continue
				}

				if moduleDataMatch {
					subData = ""
					//sample subDataMatch
					//route {
					modPat := regexp.MustCompile(MODULEDATAPATTERN)
					match := modPat.FindStringSubmatch(line)

					// Extract captured groups
					if len(match) > 1 {
						dataKey = strings.TrimSpace(match[1]) // Print the captured group
					}
					subData = "__" + dataKey

					//resourceName = resourceName+"_"+subData
					appendStrings += line+"\n"
					continue
				}
				//fmt.Printf("key: %s Val: %s", dataKey, dataVal)

				if dataKey != "" && dataVal != "" {
					substringToCheck := "${data."
					if strings.Contains(dataVal, substringToCheck) {
						appendStrings += line+"\n"
						continue
					}
					dataName = resourceName + subData + "__" + dataKey
					//fmt.Println("insideData" + resourceName + "__" + dataName)
					varDeclaration := fmt.Sprintf(`variable "%s" {`+"\n"+`  default = "%s"`+"\n"+`}`+"\n\n"+``, dataName, dataVal)
					//dataNamestr := strings.ReplaceAll(line,`""`,``)
					//appendStrings = strings.ReplaceAll(appendStrings, `"`,``)
					varData := fmt.Sprintf("%s\n", strings.ReplaceAll(line, dataVal, "var."+dataName))
					appendStrings += strings.ReplaceAll(varData, "\"", "")
					//appendStrings += line
					// Append to variable declarations
					varDeclarations += varDeclaration
					//output = strings.ReplaceAll(input, varValue, fmt.Sprintf("var.%s_%s__%s", resourceType, resourceName, varName))
				} else {
					appendStrings += line+"\n"
					//check tag pattern
					continue
				}
			} else if subDataMatch {
				appendStrings += line+"\n"
				fmt.Println("no match: " + line)
				continue
			}
		} else {
			appendStrings += line+"\n"
		}
	}

	// Add the generated variable declarations to the output
	appendStrings += "\n\n\n#MD Generated Variables\n\n" + varDeclarations
	return []byte(appendStrings), nil
}

func dynamicResVariableNameFormation(res string) string {
	//sample res value should be
	//resource "aws_subnet" "tfer--subnet-00dfb1aa914c8467f
	resPat := regexp.MustCompile(RESOURCEPATTERN)
	matches := resPat.FindStringSubmatch(res)
	if len(matches) == 3 {
		resourceType := matches[1]
		resourceName := matches[2]
		resName := resourceType + "_" + resourceName
		return resName
	} else {
		return ""
	}
}

func dynamicDataVariableNameFormation(data string) (string, string) {
	//sample data value should be
	//enable_dns64 = "false"
	dataPat := regexp.MustCompile(DATAPATTERN)
	sdataPat := regexp.MustCompile(SUBDATAPATTERN)
	matches := dataPat.FindStringSubmatch(data)
	matchess := sdataPat.FindStringSubmatch(data)
	var dataKey, dataValue string
	if len(matches) > 0 {
		dataKey = matches[1]
		dataValue = matches[2]
		//dataName := dataKey+"_"+dataValue
		return dataKey, dataValue
	} else if len(matchess) > 0 {
		dataKey = matchess[0]
		dataValue = matchess[1]
		return dataKey, dataValue
	} else {
		//fmt.Println("no match found1")
		return "", ""
	}
}
