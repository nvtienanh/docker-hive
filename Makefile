HIVE_TAG := 2.3.4-hadoop3.2.0
build:
	docker build -t nvtienanh/hive:$(HIVE_TAG) ./
push:
	docker push nvtienanh/hive:$(HIVE_TAG)
