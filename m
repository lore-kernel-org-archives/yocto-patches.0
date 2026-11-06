Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12300.1793932700628563294
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Nov 2026 18:38:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wC3StUjPe1q74cDAA--.14010S3;
	Fri, 06 Nov 2026 10:36:19 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowADneWrLPO1qw8MtAA--.53598S3;
	Fri, 06 Nov 2026 10:34:56 +0800 (CST)
Message-ID: <1dddd59c-3c1d-4461-9828-392385b9e746@cetc.com.cn>
Date: Fri, 6 Nov 2026 10:38:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches][meta-selinux][wrynose][PATCH 1/2]
 selinux-sandbox: fix CVE-2026-59676
To: yocto-patches@lists.yoctoproject.org
Cc: Darsh Kelaiya <dkelaiya@cisco.com>
References: <20261105070617.839020-1-dkelaiya@cisco.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <20261105070617.839020-1-dkelaiya@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C6CowADneWrLPO1qw8MtAA--.53598S3
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYDCmrshhUL4wAAsw
X-CM-DELIVERINFO: =?B?QV1Wa6c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOIpW4/8Z0l7A1TJMY5S9w3q04JsFKj1OJYWOmvApiuhzT6dEgh9B12DWQiFPLsq+2Oap
	lVkZ9aJFLpojPk8zcjaLKWIs9QtIqyraOmA/GD2SC/PswAQhh0G5KyOTr6cN9w==
X-Coremail-Antispam: 1Uk129KBj93XoWxXw1xAr4xur15Ar45Aw48Xwc_yoW5ur4DpF
	W5Ga13GrZ7GFs3urn7WF12vF4UXw4ru347WFZ8WrW5XFyakFykXas5Kry3CrW3XF95GayU
	A3WUZr95K34UAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYF7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	GVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU8UDG5UUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Nov 2026 02:38:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5245

Both merged.

Regards,
Qi

On 11/5/26 15:06, Darsh Kelaiya -X (dkelaiya - E INFOCHIPS PRIVATE 
LIMITED at Cisco) via yocto-patches wrote:
> From: Darsh Kelaiya <dkelaiya@cisco.com>
>
> This patch applies the upstream fix as referenced in [2],
> using the commit shown in [1].
>
> The 3.10 rm_rf() implementation follows symlinks after checking
> directory entries, allowing a setuid seunshare caller to remove
> root-owned files. Add O_NOFOLLOW to its recursive openat() call.
>
> [1] https://github.com/SELinuxProject/selinux/commit/38f0a4d9a683f2cd2472d4502842df5d5b8255a8
> [2] https://security.opensuse.org/2026/07/15/selinux-seunshare.html
>
> Signed-off-by: Darsh Kelaiya <dkelaiya@cisco.com>
> ---
>   .../selinux-sandbox/CVE-2026-59676.patch      | 33 +++++++++++++++++++
>   .../selinux/selinux-sandbox_3.10.bb           |  1 +
>   2 files changed, 34 insertions(+)
>   create mode 100644 recipes-security/selinux/selinux-sandbox/CVE-2026-59676.patch
>
> diff --git a/recipes-security/selinux/selinux-sandbox/CVE-2026-59676.patch b/recipes-security/selinux/selinux-sandbox/CVE-2026-59676.patch
> new file mode 100644
> index 0000000..1356381
> --- /dev/null
> +++ b/recipes-security/selinux/selinux-sandbox/CVE-2026-59676.patch
> @@ -0,0 +1,33 @@
> +From 38f0a4d9a683f2cd2472d4502842df5d5b8255a8 Mon Sep 17 00:00:00 2001
> +From: Stephen Smalley <stephen.smalley.work@gmail.com>
> +Date: Tue, 12 May 2026 14:34:02 -0400
> +Subject: [PATCH] sandbox/seunshare: pass O_NOFOLLOW to openat()
> +
> +We do not want to follow symlinks here.
> +
> +CVE: CVE-2026-59676
> +Upstream-Status: Backport [https://github.com/SELinuxProject/selinux/commit/38f0a4d9a683f2cd2472d4502842df5d5b8255a8]
> +
> +Acked-by: James Carter <jwcart2@gmail.com>
> +Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> +(cherry picked from commit 38f0a4d9a683f2cd2472d4502842df5d5b8255a8)
> +Signed-off-by: Darsh Kelaiya <dkelaiya@cisco.com>
> +---
> + sandbox/seunshare.c | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> +index e89a9fec..a1900eaa 100644
> +--- a/sandbox/seunshare.c
> ++++ b/sandbox/seunshare.c
> +@@ -428,7 +428,7 @@ static bool rm_rf(int targetfd, const char *path) {
> + 	}
> +
> + 	if (S_ISDIR(statbuf.st_mode)) {
> +-		const int newfd = openat(targetfd, path, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
> ++		const int newfd = openat(targetfd, path, O_RDONLY | O_DIRECTORY | O_NOFOLLOW | O_CLOEXEC);
> + 		if (newfd < 0) {
> + 			perror("openat");
> + 			return false;
> +--
> +2.35.6
> diff --git a/recipes-security/selinux/selinux-sandbox_3.10.bb b/recipes-security/selinux/selinux-sandbox_3.10.bb
> index d29cd88..f8ffd36 100644
> --- a/recipes-security/selinux/selinux-sandbox_3.10.bb
> +++ b/recipes-security/selinux/selinux-sandbox_3.10.bb
> @@ -10,6 +10,7 @@ LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=393a5ca445f6965873eca0259a17f833"
>   require selinux_common.inc
>   
>   SRC_URI += "file://sandbox-de-bashify.patch;patchdir=.. \
> +            file://CVE-2026-59676.patch;patchdir=.. \
>              "
>   
>   S = "${UNPACKDIR}/${BP}/sandbox"

