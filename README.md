# devops-netology
Test

###¬ыполнение задани¤
# Local .terraform directories
**/.terraform/* #будут проигнорированы все файлы и папки во всех каталогах .terraform, где бы каталог .terraform находилс¤

# .tfstate files
*.tfstate    # проигнорировать файлы с расширением  .tfstate
*.tfstate.*  # проигнорировать все файлы в имени которых встречаетс¤ .tfstate.

# Crash log files
crash.log #проигнорировать файл crash.log
crash.*.log #проигнорировать файл, соотвествующий маске crash.Ћюбое«начение.log 

# Exclude all .tfvars files, which are likely to contain sentitive data, such as
# password, private keys, and other secrets. These should not be part of version
# control as they are data points which are potentially sensitive and subject
# to change depending on the environment.
#
*.tfvars  #проигнорировать все файлы с расширением .tfvars

# Ignore override files as they are usually used to override resources locally and so
# are not checked in
override.tf    # игнорировать файлы override.tf
override.tf.json  # игнорировать файлы override.tf.json
*_override.tf  #игнорировать файлы соответствующие маске Ћюбое«начение_override.tf
*_override.tf.json #игнорировать файлы соответствующие маске Ћюбое«начение_override.tf.json

# Include override files you do wish to add to version control using negated pattern
#
# !example_override.tf

# Include tfplan files to ignore the plan output of command: terraform plan -out=tfplan
# example: *tfplan*

# Ignore CLI configuration files
.terraformrc  #не включать файлы .terraformrc
terraform.rc  #не включать файлы terraform.rc