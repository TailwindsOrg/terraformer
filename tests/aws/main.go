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
	//"os/exec"
	"github.com/GoogleCloudPlatform/terraformer/cmd"
	//aws_terraforming "github.com/GoogleCloudPlatform/terraformer/providers/aws"
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
		"--resources=ec2_instance",
		//"--resources=route_table,igw",
		//"--filter=Name=tags.owner;Value=MD",
		//"--filter=Name=vpc;Value=vpc-04091db1b44b52c43",
		"--filter=ec2=i-04a3058688e50ee7c",
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
}

