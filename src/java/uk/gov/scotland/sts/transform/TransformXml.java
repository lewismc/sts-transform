/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package uk.gov.scotland.sts.transform;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * FILE:TransformXml.java
 * -----------------------
 * This file takes in either an @param -inputFile or @param -inputDir,
 * then validates the input document(s) against a user defined XSD before
 * dumping the resulting XML to an @param -outputDir.
 * 
 * @author lewismc
 * @date 14/12/2011
 *
 */
public class TransformXml {

  public static final Logger LOG = LoggerFactory.getLogger(TransformXml.class);
  /**
   * @param args
   */
  public TransformXml(){
    
  }
  
  public int main(String[] args) throws Exception{
    Boolean inputFile = false;
    Boolean inputDir = false;
    String xsdFile = null;
    String outputDir = null;
    
    String usage = ("Usage: TransformXml [-inputFile] [-inputDir] <XSD file> <output dir>");
    
    if (args.length == 0) {
      System.err.println(usage);
      return(-1);
    }
    for (int i = 0; i < args.length; i++) {
      if (args[i].equals("-inputFile")) {
        inputFile = true;
      } else if (args[i].equals("-inputDir")) {
        inputDir = true;
      } else if (i != args.length - 1) {
        System.err.println(usage);
        System.exit(-1);
      } else {
        xsdFile = args[i];
        outputDir = args[1];
      }
    }
    if (LOG.isInfoEnabled()) {
      if(inputFile = true) {
        LOG.info("Validating file" + inputFile + "with: " + xsdFile + "\n");
      } else if (inputDir = true){
        LOG.info("Validating documents in" + inputDir + "with: " + xsdFile + "\n");
      }
      LOG.info("Transforming to XML and storing in: " + outputDir + "\n");
    }
    
    return 0;
  }

}
