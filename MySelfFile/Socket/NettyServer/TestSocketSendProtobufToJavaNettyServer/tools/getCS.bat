echo on
protoc --version

protoc --descriptor_set_out=Bean/ProtoEmpBean.protobin --include_imports Bean/ProtoEmpBean.proto


protogen Bean/ProtoEmpBean.protobin