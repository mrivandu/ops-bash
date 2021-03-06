# Some commonly function modules

we can easily use them in our own scripts.

## sendmail.sh

- 这是一个发送邮件的模块。

- 要求系统已经安装 mailx 。如果系统没有安装 mailx ，那么会在系统上安装 mailx 。

- 如果没有配置发件账户的信息，那么会自动在系统配置发送邮件的用户信息。默认情况下使用 163 邮箱进行发送邮件。

- 包括五个参数。分别是发件账户、发送账户的密码、收件人邮箱、邮件主题、邮件正文的文件路径。

- 使用示例。在脚本 memory_usage.sh 中引用该模块。

memory_usage.sh 内容如下：
  
```bash
#!/bin/bash
. $(pwd)/sendmail.sh
sendmail my_account my_passwd dst_mail@163.com Memory_usage /tmp/mail.text
```

执行结果：

![执行结果](https://raw.githubusercontent.com/mrivandu/ops/master/images/sendmail.jpg)

## monitor_memoey_usage_precentage.sh

- 可用内存占比检测，传入的参数是限制阈值百分比。比如设置的阈值是：20%，当可用内存百分比小于 20% 时打印内存不足的提示。此时传入的参数为：20。当然，也可以使用之前的模块进行邮件报警。注意：脚本中使用了[[ ]],此处不能使用[]。

- 在其他脚本中引用示例。
  
```bash
. ${yourpath}/monitor_memoey_usage_precentage.sh
deteciton $1
```

## original_fingerprint_md5sum.sh

- 用于生成指定目录下的文件的原始 MD5 校验和。

- 需要传入一个参数，即：需要校验的目录路径。校验完成后会在当前目录生成一个名为 ori_md5sum.db 的原始校验文件，该文件用于后期的验证。

- 用法示例：

```bash
. ${yourpath}/original_fingerprint_md5sum.sh
ori_md5sum $1
```

## check_fingerprint_md5sum.sh

- 用于检查指定目录的 MD5 校验和。

- 需要传入2个参数，原始 MD5 校验和文件和指定路径，可以与 original_fingerprint_md5sum.sh 配合使用。

- 用法示例：

```bash
. ${yourpath}/original_fingerprint_md5sum.sh
check_md5sum $1 $2
```