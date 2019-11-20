```
plans=($(terraform plan | grep Plan | grep -wo '[0-9]\{1,\}'))
echo ${plans[@]}
echo ${#plans[@]}

terraform apply -auto-approve
```