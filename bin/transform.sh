#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 
# The sts-transform command script
#
# Environment Variables
#
#   STS_JAVA_HOME The java implementation to use.  Overrides JAVA_HOME.
#
#   STS_HEAPSIZE  The maximum amount of heap to use, in MB. 
#                   Default is 1000.
#
#   STS_OPTS      Extra Java runtime options.
#
cygwin=false
case "`uname`" in
CYGWIN*) cygwin=true;;
esac

# resolve links - $0 may be a softlink
THIS="$0"
while [ -h "$THIS" ]; do
  ls=`ls -ld "$THIS"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '.*/.*' > /dev/null; then
    THIS="$link"
  else
    THIS=`dirname "$THIS"`/"$link"
  fi
done

# if no args specified, show usage
if [ $# = 0 ]; then
  echo "Usage: sts-transform [-core] COMMAND"
  echo "where COMMAND is one of:"
  echo "  transform              one-step script for HTML --> RDF/XML transformations"
  echo "  transform-xml          intermediate script for HTML --> XML transformations"
  echo "  transform-annotate     intermediate script for XML --> annotated XML transformations"
  echo "  transform-rdf/xml      intermediate script for annotated XML --> RDF/XML transformations"
  echo "  junit		         runs the given JUnit test"
  echo " or" 
  echo "  CLASSNAME              run the class named CLASSNAME"
  echo "Most commands print help when invoked w/o parameters."
  exit 1
fi

# get arguments
COMMAND=$1
shift

# some directories
THIS_DIR=`dirname "$THIS"`
STS_HOME=`cd "$THIS_DIR/.." ; pwd`

# some Java parameters
if [ "$STS_JAVA_HOME" != "" ]; then
  #echo "run java in $STS_JAVA_HOME"
  JAVA_HOME=$STS_JAVA_HOME
fi
  
if [ "$JAVA_HOME" = "" ]; then
  echo "Error: JAVA_HOME is not set."
  exit 1
fi

local=true
  
  
  
  
  
  
  
  
  
