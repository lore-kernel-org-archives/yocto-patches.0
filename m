Return-Path: <wuxiaotian@loongson.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ED0C28B28
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 03:20:46 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by mx.groups.io with SMTP id smtpd.web11.6370.1741836034897506722
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Mar 2025 20:20:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: loongson.cn, ip: 114.242.206.163, mailfrom: wuxiaotian@loongson.cn)
Received: from loongson.cn (unknown [192.168.100.1])
	by gateway (Coremail) with SMTP id _____8CxvnL1TtJnTV2UAA--.56240S3;
	Thu, 13 Mar 2025 11:20:22 +0800 (CST)
Received: from [10.40.24.15] (unknown [192.168.100.1])
	by front1 (Coremail) with SMTP id qMiowMDxu8TzTtJnPZ5HAA--.1631S3;
	Thu, 13 Mar 2025 11:20:20 +0800 (CST)
Message-ID: <5ef7f5dd-911f-4a94-b008-333c39bc504f@loongson.cn>
Date: Thu, 13 Mar 2025 11:20:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pseudo] [PATCH 0/3] Add support for LoongArch
To: yocto-patches@lists.yoctoproject.org
References: <20250309054345.453202-1-wuxiaotian@loongson.cn>
Content-Language: en-US
From: Xiaotian Wu <wuxiaotian@loongson.cn>
In-Reply-To: <20250309054345.453202-1-wuxiaotian@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxu8TzTtJnPZ5HAA--.1631S3
X-CM-SenderInfo: 5zx0xtprwlt0o6or00hjvr0hdfq/1tbiAQEACGfSDkwD5QAAsZ
X-Coremail-Antispam: 1Uk129KBj93XoW7tw1rWF18CFyxZw45CFy5KFX_yoW8AF4kpr
	s3Ar4fKFn7Jr1xKrsIqw10gryYyw1rG3y7Xw43A390kFZ5Jryrtr9FgF98GrnrAw1rXr1j
	kw4kA3WDWF15XwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUJVWUXwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Mar 2025 03:20:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1197

LoongArch is a new ISA introduced by Loongson[1] and supported since 
linux-5.19. Support for LoongArch has also been added to oe-core since 2023.

I've been using x86 as the host for my builds, but recently I've noticed 
that when I build with a LoongArch machine as the host, pseudo fails, 
causing the installation to exit with an error.

These patches add support for the LoongArch architecture in pseudo so 
that we can build with a LoongArch machine as the host.

[1]: https://loongson.cn/EN

在 2025/3/9 13:43, Xiaotian Wu 写道:
> Porting pseudo to LoongArch, and make test passed.
>
> $ uname -m
> loongarch64
> $ make test
> ./run_tests.sh -v
> test-acl: Passed.
> test-chroot: Passed.
> test-chroot-symlink: Passed.
> test-cp-setuid: Passed.
> test-dir-move: Passed.
> test-env_i: Passed.
> test-execl: Passed.
> test-fcntl: Passed.
> test-fstat: Passed.
> test-openat: Passed.
> test-open-symlinks: Passed.
> test-pseudo_disable-fork-env_i: Passed.
> test-pseudo_disable-fork: Passed.
> test-pseudo_unload-fork-env_i: Passed.
> test-pseudo_unload-fork: Passed.
> test-reexec-chroot: Passed.
> test-relative-from-root: Passed.
> test-rename-fstat: Passed.
> couldn't allocate absolute path for 'null'.
> test-statx: Passed.
> test-tclsh-fork: Passed.
> test-umask: Passed.
> test-xattr: Passed.
> 22/22 test(s) passed.
>
>
> Xiaotian Wu (3):
>    pseudo_wrappers.c: Add support for LoongArch64
>    Makefile.in: Use ARCH_FLAGS instead of -m32 and -m64
>    configure: Add support for LoongArch
>
>   Makefile.in       |  4 +--
>   configure         | 11 +++++++-
>   pseudo_wrappers.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 82 insertions(+), 3 deletions(-)
>
-- 
Best Regards
Xiaotian Wu


