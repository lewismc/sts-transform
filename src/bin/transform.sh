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
  echo "  transformFull         full script for HTML --> RDF/XML transformations"
  echo "  transformXml          HTML --> XML transformations"
  echo "  transformAnnotate     XML --> annotated XML transformations"
  echo "  transformRdfxml       annotated XML --> RDF/XML transformations"
  echo "  junit                 runs the given JUnit test"
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

JAVA=$JAVA_HOME/bin/java
JAVA_HEAP_MAX=-Xmx1000m 

# check envvars which might override default args
if [ "$STS_HEAPSIZE" != "" ]; then
  #echo "run with heapsize $STS_HEAPSIZE"
  JAVA_HEAP_MAX="-Xmx""$STS_HEAPSIZE""m"
  #echo $JAVA_HEAP_MAX
fi

# CLASSPATH initially contains $STS_CONF_DIR, or defaults to $STS_HOME/conf
CLASSPATH=${STS_CONF_DIR:=$STS_HOME/conf}
CLASSPATH=${CLASSPATH}:$JAVA_HOME/lib/tools.jar

# so that filenames w/ spaces are handled correctly in loops below
IFS=

# add libs to CLASSPATH
if $local; then
  for f in $STS_HOME/lib/*.jar; do
   CLASSPATH=${CLASSPATH}:$f;
  done
  # local runtime
  # add plugins to classpath
  if [ -d "$STS_HOME/plugins" ]; then
     CLASSPATH=${STS_HOME}:${CLASSPATH}
  fi
fi

# restore ordinary behaviour
unset IFS

# default log directory & file
if [ "$STS_LOG_DIR" = "" ]; then
  STS_LOG_DIR="$STS_HOME/logs"
fi
if [ "$STS_LOGFILE" = "" ]; then
  STS_LOGFILE='sts-transform.log'
fi

#Fix log path under cygwin
if $cygwin; then
  STS_LOG_DIR=`cygpath -p -w "$STS_LOG_DIR"`
fi

if [ "x$JAVA_LIBRARY_PATH" != "x" ]; then
  STS_OPTS="$STS_OPTS -Djava.library.path=$JAVA_LIBRARY_PATH"
fi

# figure out which class to run
if [ "$COMMAND" = "transform" ] ; then
  CLASS=uk.gov.scotland.sts.transform.TransformFull
elif [ "$COMMAND" = "transform-xml" ] ; then
  CLASS=uk.gov.scotland.sts.transform.TransformXml
elif [ "$COMMAND" = "transform-annotate" ] ; then
  CLASS=uk.gov.scotland.sts.transform.TransformAnnotate
elif [ "$COMMAND" = "transform-rdf/xml" ] ; then
  CLASS=uk.gov.scotland.sts.transform.TransformRdfXml
elif [ "$COMMAND" = "junit" ] ; then
  CLASSPATH=$CLASSPATH:test/classes/
  CLASS=junit.textui.TestRunner
else
  MODULE="$COMMAND"
  CLASS=$1
  shift
fi

if $local; then
 EXEC_CALL="$JAVA $JAVA_HEAP_MAX $NUTCH_OPTS -classpath $CLASSPATH"
fi

# run it
exec $EXEC_CALL $CLASS "$@"
  
  
