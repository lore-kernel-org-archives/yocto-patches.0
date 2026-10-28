Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40063.1793185379379582873
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Oct 2026 04:03:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wBHX+H31eFq1ksAAA--.29S3;
	Wed, 28 Oct 2026 19:01:12 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowADnd2ih1eFqsmomAA--.2094S2;
	Wed, 28 Oct 2026 18:59:46 +0800 (CST)
Message-ID: <0a94c2f7-bf4e-4c4a-a255-dd47fbeb7f71@cetc.com.cn>
Date: Wed, 28 Oct 2026 19:02:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH] libselinux-python: fix the
 build against swig 4.5.0
To: yocto-patches@lists.yoctoproject.org, ricardo.salveti@oss.qualcomm.com
References: <20260817163027.2274986-1-ricardo.salveti@oss.qualcomm.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <20260817163027.2274986-1-ricardo.salveti@oss.qualcomm.com>
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowADnd2ih1eFqsmomAA--.2094S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYOCmrgqk4fgQAAsz
X-CM-DELIVERINFO: =?B?7YYwMKc9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOLy7F2L/bYVz82xzNKeppBhD/mGH+DyMFJ5Sw1++rcMG+AhdJQCWFBXAlGKskPYU48by
	L/yXwAyFZhXET7EEtBFj9nRwi6cHZgV3fTS1qLc6R4sgFwf50jT8LwE5rAFRrw==
X-Coremail-Antispam: 1Uk129KBj93XoWxXF48trW8JrWruryxJF4fJFc_yoWrZFW7pF
	s0kFsIqF93AF4xJws7Xa42vrW3Wr4rCa47uFW5GF1j9Fy8uFyIv39Ig34akrnrCw4vga1a
	vr10qws5C3yxJrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_Gw7v73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYY7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc2
	xSY4AK67AK6r4kMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXV
	WUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU
	2jXdUUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 11:03:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5169
Content-Type: text/plain; charset="utf-8"; format="flowed"

Merged

Regards,
Qi

On 8/18/26 00:30, Ricardo Salveti via lists.yoctoproject.org wrote:
> swig 4.5.0 removed the Python 2 C API compatibility macros from its
> pyhead.swg runtime header, and libselinux 3.10 still calls
> PyString_FromString() from selinuxswig_python.i, so the generated
> wrapper no longer compiles:
>
>    selinuxswig_python_wrap.c:11583:34: error: passing argument 3 of
>    'PyList_SetItem' makes pointer from integer without a cast
>
> Backport the upstream fix, which switches the three call sites to
> PyUnicode_FromString().
>
> Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
> ---
>   .../selinux/libselinux-python_3.10.bb         |  1 +
>   ...e-PyString_FromString-with-PyUnicode.patch | 52 +++++++++++++++++++
>   2 files changed, 53 insertions(+)
>   create mode 100644 recipes-security/selinux/libselinux/0004-libselinux-Replace-PyString_FromString-with-PyUnicode.patch
>
> diff --git a/recipes-security/selinux/libselinux-python_3.10.bb b/recipes-security/selinux/libselinux-python_3.10.bb
> index 139e6df..e0fcb4b 100644
> --- a/recipes-security/selinux/libselinux-python_3.10.bb
> +++ b/recipes-security/selinux/libselinux-python_3.10.bb
> @@ -15,6 +15,7 @@ SRC_URI += "\
>           file://0001-Makefile-fix-python-modules-install-path-for-multili.patch;patchdir=.. \
>           file://0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch;patchdir=.. \
>           file://0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch;patchdir=.. \
> +        file://0004-libselinux-Replace-PyString_FromString-with-PyUnicode.patch;patchdir=.. \
>           "
>   
>   S = "${UNPACKDIR}/${BP}/libselinux"
> diff --git a/recipes-security/selinux/libselinux/0004-libselinux-Replace-PyString_FromString-with-PyUnicode.patch b/recipes-security/selinux/libselinux/0004-libselinux-Replace-PyString_FromString-with-PyUnicode.patch
> new file mode 100644
> index 0000000..0ec2fea
> --- /dev/null
> +++ b/recipes-security/selinux/libselinux/0004-libselinux-Replace-PyString_FromString-with-PyUnicode.patch
> @@ -0,0 +1,52 @@
> +From fb518ff492cd6a286f35b415cbd7fd0f6e3faedb Mon Sep 17 00:00:00 2001
> +From: Petr Lautrbach <lautrbach@redhat.com>
> +Date: Thu, 6 Aug 2026 16:30:44 +0200
> +Subject: [PATCH] libselinux: Replace PyString_FromString with
> + PyUnicode_FromString for SWIG 4.5.0 compatibility
> +
> +SWIG 4.5.0 removed Python 2 C API compatibility macros (PyInt_*,
> +PyString_*, SWIG_Python_str_*) from its runtime header pyhead.swg.
> +These macros previously mapped deprecated Python 2 C API names to their
> +Python 3 equivalents.
> +
> +Fixes: https://github.com/SELinuxProject/selinux/issues/538
> +Authored-by: Jitka Plesníková <jplesnik@redhat.com>
> +Upstream-Status: Backport [https://github.com/SELinuxProject/selinux/commit/fb518ff492cd6a286f35b415cbd7fd0f6e3faedb]
> +
> +Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> +Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> +---
> + libselinux/src/selinuxswig_python.i | 6 +++---
> + 1 file changed, 3 insertions(+), 3 deletions(-)
> +
> +diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
> +index c8c08a407..74d923e42 100644
> +--- a/libselinux/src/selinuxswig_python.i
> ++++ b/libselinux/src/selinuxswig_python.i
> +@@ -69,7 +69,7 @@ def install(src, dest):
> + 	PyObject* list = PyList_New(*$2);
> + 	int i;
> + 	for (i = 0; i < *$2; i++) {
> +-		PyList_SetItem(list, i, PyString_FromString((*$1)[i]));
> ++		PyList_SetItem(list, i, PyUnicode_FromString((*$1)[i]));
> + 	}
> + 	$result = SWIG_AppendOutput($result, list);
> + }
> +@@ -123,7 +123,7 @@ def install(src, dest):
> + 			len++;
> + 		plist = PyList_New(len);
> + 		for (i = 0; i < len; i++) {
> +-			PyList_SetItem(plist, i, PyString_FromString((*$1)[i]));
> ++			PyList_SetItem(plist, i, PyUnicode_FromString((*$1)[i]));
> + 		}
> + 	} else {
> + 		plist = PyList_New(0);
> +@@ -140,7 +140,7 @@ def install(src, dest):
> + 	if (*$1) {
> + 		plist = PyList_New(result);
> + 		for (i = 0; i < result; i++) {
> +-			PyList_SetItem(plist, i, PyString_FromString((*$1)[i]));
> ++			PyList_SetItem(plist, i, PyUnicode_FromString((*$1)[i]));
> + 		}
> + 	} else {
> + 		plist = PyList_New(0);

