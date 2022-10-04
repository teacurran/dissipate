THIS_FILE := $(lastword $(MAKEFILE_LIST))
PROJECT_NAME = $(notdir $(PWD))
CMD_ARGUMENTS ?= $(cmd)
.PHONY: clean build

protoc:
	protoc -I protos --dart_out=grpc:lib/generated dissipate.proto google/protobuf/timestamp.proto google/protobuf/field_mask.proto
