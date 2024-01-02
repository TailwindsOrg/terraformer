// Copyright 2018 The Terraformer Authors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package main

import (
	"log"
	"os"
	"time"

	"github.com/GoogleCloudPlatform/terraformer/cmd"
)

func main() {
	log.SetFlags(log.Ldate | log.Ltime | log.Lmicroseconds | log.Lshortfile)
	log.SetOutput(os.Stdout)

	tCommand := cmd.NewCmdRoot()
	pathPattern := "{output}/{provider}/"
	tCommand.SetArgs([]string{
		"import",
		"aws",
		"--regions=ap-south-1",
		"--resources=subnet,vpc,route_table,igw,eip,nat",
		//"--resources=route_table,igw",
		//"--filter=Name=tags.owner;Value=MD",
		//"--filter=Name=vpc;Value=vpc-04091db1b44b52c43",
		//"--filter=vpc=vpc-0835c18918ec1f6ab",
		// "--verbose",
		//"--compact",
		"--path-pattern=" + pathPattern,
	})
	start := time.Now()
	if err := tCommand.Execute(); err != nil {
		log.Println(err)
		os.Exit(1)
	}
	log.Printf("Importing took %s", time.Since(start))
	// start = time.Now()
	// runTerraform(pathPattern)
	// log.Printf("Terraform init + plan took %s", time.Since(start))
}

// func runTerraform(pathPattern string) {
// 	rootPath, _ := os.Getwd()
// 	provider := &aws_terraforming.AWSProvider{}

// 	currentPath := cmd.Path(pathPattern, provider.GetName(), "", cmd.DefaultPathOutput)
// 	if err := os.Chdir(currentPath); err != nil {
// 		log.Println(err)
// 		os.Exit(1)
// 	}
// 	tfCmd := exec.Command("sh", "-c", "terraform init && terraform plan")
// 	tfCmd.Stdout = os.Stdout
// 	tfCmd.Stderr = os.Stderr
// 	err := tfCmd.Run()
// 	if err != nil {
// 		log.Println(err)
// 		os.Exit(1)
// 	}
// 	err = os.Chdir(rootPath)
// 	if err != nil {
// 		log.Println(err)
// 	}
// }
