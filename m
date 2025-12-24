Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6600E7545C
	for <webhook@archiver.kernel.org>; Wed, 24 Dec 2025 13:44:01 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.120679.1766583836786775949
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Dec 2025 05:43:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=DDnZVO7b;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=XG5ulaiF;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BOBPA0V461351
	for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Dec 2025 13:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/T6s4YnnD7/vTurbLGULdJymPNqpDB12rObSj+wI+Mo=; b=DDnZVO7bxmqUIXlg
	M/9GajLOmb5qCe/UZL98jsSydegoc/p/9I61X2IHTDmPp6QpS5y7O9xRddQwQPeq
	hGd9wdmfs+5uK8jFeEvfgZt4wYccotQRjFWaNmdJRV/NyA8JBhRopE77v9m1Ug4N
	iwToYCtBHiwB2jMDPpU6aaz6HKutKxwvS20Ymgy8F6k0jDK0XTNfc+krRoTaeK+3
	95gIV6RUoJhDSNzm0IIWv9uSHTdmPy7HfqyfGzh6VL/56hccBwpnt/F0gCKMYPdI
	KVChz7pgvw4NlqMjN/a8vbodPjIQsgo4peoopojKnWt4T1emfYNWaAzzWL0dKYiM
	ygKgPg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7w8fu9ud-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Dec 2025 13:43:56 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a2e9e09e6so199402106d6.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Dec 2025 05:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766583835; x=1767188635; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/T6s4YnnD7/vTurbLGULdJymPNqpDB12rObSj+wI+Mo=;
        b=XG5ulaiFMQ4e7EshDSIs2hXaEtOYnfS9St/jCVm0EpxwePfKvWOS/HtEXGkhS932Fa
         Ay/SyrgxYUGI1tTT41G4InwwZ+FMTY5SzTV7f7mrlsz3FyvGjF2WWG7DiiQe9kMMnyfs
         xSuctTn0Qg6cUa1coKadXGb+fOO7UNItGjzyV9HmOvVftt77PfrdnPS8nIW8Q2X3x+tf
         lBEHvqascLGUAZqoERb2IHH0exX3zLBNK9vtIGfP2MjbiDC0sNGpEQTYqJI89KCpKg/8
         gzJYnKjzcHVW/Ry50eOcaA+X2eat4EGMpyykVZ5tIpV6P3p/gDzNKHd/2EYR6iFwuSbR
         IMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766583835; x=1767188635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/T6s4YnnD7/vTurbLGULdJymPNqpDB12rObSj+wI+Mo=;
        b=lj/fAnr1YlsDZ3E9m5dZYbx/hKBFZj6W58FYNrKC+eW/P2mHa79yvOy8gdf7mNpjw0
         7+cReuhMp5Reb77OGNSL91oEKV+kSSF48q7HtuzlWlgnvytLTnoDVdfKNAECTSxOtLqb
         4Z9lZdHpdL+uVSKNCv7Ei0IAHnRubTRHTtBPry8N9JrK981nBnDItwIHCvn8bzm1MuqO
         ngUmhhmR771CwiquujuFuxIEMxfkxf7rSFAYWQROjSyx6XzOoa1gANhgKmowBiqwUfqU
         VdMlNHjsJD0iwYz6nv4jUWJqnbwK+61dOmHnL7i+fARucZoR4g8JQGja6GrrS8dR/CR9
         6cBA==
X-Gm-Message-State: AOJu0YzXxNDaSsT/7H9htzq21BWkmLSeQc3eK8RIS1jkFiMhhzuDooJb
	MGr1k9k1rnL0Sd/0VoWltiIHbFdUFLlGSBrJRCMURGCrHVlIvm2XRiU4mxzeRAtWbN11Gst2CtP
	SYyn1CLokidhh8I0BFwvlokqDqiTcNHeDSyzFHTeD6EoJxhkur/N40sc8VUnfjVJVrHrWGtOFhY
	arUo/L8wMUty7X3wkl799Z6pSNJkGAGl7ULJoWc7GVEMxMzehYcysy
X-Gm-Gg: AY/fxX5JShZ2E9588lORF3mqz/p4eVo7qXOwbRg1oHiQykPafWuIiQqk6xzSkCj+Tkj
	8nsAbZtNAzQk4cWYq6qkizgi8A6faJQ3+LmoTzhSpMDt7W82BGrQdcoG3lQL3cdBU2Mb/uT7zZS
	/6gKuj/sdfcswwsvZoo/H0vJrnL3byAGKjGdSIqy1CGulxRIVW4ycGWLSVMltknfhs
X-Received: by 2002:a05:620a:414c:b0:8ab:7ac3:3271 with SMTP id af79cd13be357-8c08fbbc0c9mr2607680285a.36.1766583835092;
        Wed, 24 Dec 2025 05:43:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnd1RQr9ydKHRNK7DCHKWsaHJ1rPYURkXttTQHe+yOzLVBnnRTZ2PlvMarW6UDN6j10R6p/F2r8wSdk7ufsUM=
X-Received: by 2002:a05:620a:414c:b0:8ab:7ac3:3271 with SMTP id
 af79cd13be357-8c08fbbc0c9mr2607677785a.36.1766583834499; Wed, 24 Dec 2025
 05:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20251223123716.3025878-1-ruiqiang.hao@windriver.com>
In-Reply-To: <20251223123716.3025878-1-ruiqiang.hao@windriver.com>
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
Date: Wed, 24 Dec 2025 21:43:43 +0800
X-Gm-Features: AQt7F2rRStSqAyhr2ZaPDKatzNk6YYM-DPqm8EH9ZMU_0fzwh4Cx2GqrGVEtn6Y
Message-ID: <CA+s=J=yo1H2KSHGS5F9Hko+CBuwaJsc=TBNjoNNRn63gO79MWQ@mail.gmail.com>
Subject: Re: [meta-dpdk][PATCH v4] dpdk: upgrade 22.11.7 -> 25.11.0
To: Ruiqiang Hao <ruiqiang.hao@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: zGH1IiAseij513AHm1l6IFvewlexzEiy
X-Proofpoint-ORIG-GUID: zGH1IiAseij513AHm1l6IFvewlexzEiy
X-Authority-Analysis: v=2.4 cv=QutTHFyd c=1 sm=1 tr=0 ts=694bee1c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8
 a=xNf9USuDAAAA:8 a=PYa8BluY_o-pDVh8M-4A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDEyMCBTYWx0ZWRfX9YOqtfn09wra
 zIso30E2JEtjnlIyCGS/JBRN/fknTWA8VDkkoHpTyFrJbZePpsAHwp2r2AJVM7afUNwVH6i7fYN
 KM+xtEn2vizm5zSEbH1BgkIBOhIkm0wwZrxl02nQnIskK4uo5aZOdPyuZ4TLf51LdPG61hBJ3jQ
 vlMdgiym7y35sSKRjcjI6NWb3+xTIJvYFZxunS2rMLNSdoE2GhWDdGpk5u4vpBhCpCsO4SvozVF
 TjBvJj+mhVZjXa/oY12ONwWAyZdzwwwUSAxjZZ9SykBHfScb9LtSePTc00O+EhKzhG9K9RVd5+X
 n8hK0n8s3t9DlNcvM/WOrt+bOhzh2lQB85zVzIDE4NN5ohTp7ADWH17ihWxyScuua3QchM5E2sk
 GEyGOeBw4clXYOIa/6xpnkiBcCXdx82Ya0cZRYYxOaXZYlqFArmM01AzG3Fi1QpldAGmW27jRbo
 VIF4WN/HT2IYKjs/zkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512240120
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Dec 2025 13:44:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2871

Thank you for the rework. I've merged this.

On Tue, Dec 23, 2025 at 8:37=E2=80=AFPM Ruiqiang Hao <ruiqiang.hao@windrive=
r.com> wrote:
>
> From: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>
>
> Upgrade to DPDK 25.11 LTS release.
>
> - Update SRCREV and branch references
> - Update library path to pmds-26.0
> - Remove dpdk-module
> - Remove patches that are no longer needed in 25.11.0:
>   * 0001-Makefile-add-makefile.patch
>   * 0001-meson.build-march-and-mcpu-already-passed-by-Yocto-21.11.patch
> - Set the cpu_instruction_set through EXTRA_OEMESON
>
> Signed-off-by: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>
> ---
>  recipes-extended/dpdk/dpdk-module_22.11.7.bb  | 49 ------------
>  .../dpdk/0001-Makefile-add-makefile.patch     | 75 -------------------
>  ...d-mcpu-already-passed-by-Yocto-21.11.patch | 38 ----------
>  .../dpdk/{dpdk_22.11.7.bb =3D> dpdk_25.11.0.bb} | 23 +++---
>  4 files changed, 13 insertions(+), 172 deletions(-)
>  delete mode 100644 recipes-extended/dpdk/dpdk-module_22.11.7.bb
>  delete mode 100644 recipes-extended/dpdk/dpdk/0001-Makefile-add-makefile=
.patch
>  delete mode 100644 recipes-extended/dpdk/dpdk/0001-meson.build-march-and=
-mcpu-already-passed-by-Yocto-21.11.patch
>  rename recipes-extended/dpdk/{dpdk_22.11.7.bb =3D> dpdk_25.11.0.bb} (72%=
)
>
> diff --git a/recipes-extended/dpdk/dpdk-module_22.11.7.bb b/recipes-exten=
ded/dpdk/dpdk-module_22.11.7.bb
> deleted file mode 100644
> index 1ce396c..0000000
> --- a/recipes-extended/dpdk/dpdk-module_22.11.7.bb
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -include dpdk.inc
> -
> -FILESEXTRAPATHS:prepend :=3D "${THISDIR}/dpdk:"
> -
> -SRC_URI +=3D " \
> -            file://0001-Makefile-add-makefile.patch \
> -"
> -STABLE =3D "-stable"
> -BRANCH =3D "22.11"
> -SRCREV =3D "077a7044cc5b2533410f691c8db6fb4f6667b1ca"
> -
> -inherit module
> -
> -#kernel module needs 'rte_build_config.h', which is generated at buid ti=
me
> -DEPENDS +=3D "dpdk"
> -
> -COMPATIBLE_MACHINE =3D "null"
> -COMPATIBLE_HOST:libc-musl:class-target =3D "null"
> -COMPATIBLE_HOST:linux-gnux32 =3D "null"
> -
> -export S
> -export STAGING_KERNEL_DIR
> -export STAGING_INCDIR
> -export INSTALL_MOD_DIR =3D "dpdk"
> -
> -do_configure[noexec] =3D "1"
> -
> -do_compile() {
> -    cd ${S}/kernel/linux/kni
> -    unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS
> -    oe_runmake KERNEL_PATH=3D${STAGING_KERNEL_DIR}   \
> -           KERNEL_VERSION=3D${KERNEL_VERSION}    \
> -           CC=3D"${KERNEL_CC}" LD=3D"${KERNEL_LD}" \
> -           AR=3D"${KERNEL_AR}" \
> -               O=3D${STAGING_KERNEL_BUILDDIR} \
> -           KBUILD_EXTRA_SYMBOLS=3D"${KBUILD_EXTRA_SYMBOLS}" \
> -           ${MAKE_TARGETS}
> -}
> -
> -do_install() {
> -    cd ${S}/kernel/linux/kni
> -    unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS
> -    oe_runmake DEPMOD=3Decho MODLIB=3D"${D}${nonarch_base_libdir}/module=
s/${KERNEL_VERSION}" \
> -               INSTALL_FW_PATH=3D"${D}${nonarch_base_libdir}/firmware" \
> -               CC=3D"${KERNEL_CC}" LD=3D"${KERNEL_LD}" \
> -               O=3D${STAGING_KERNEL_BUILDDIR} \
> -               ${MODULES_INSTALL_TARGET}
> -}
> -
> diff --git a/recipes-extended/dpdk/dpdk/0001-Makefile-add-makefile.patch =
b/recipes-extended/dpdk/dpdk/0001-Makefile-add-makefile.patch
> deleted file mode 100644
> index 0fc849b..0000000
> --- a/recipes-extended/dpdk/dpdk/0001-Makefile-add-makefile.patch
> +++ /dev/null
> @@ -1,75 +0,0 @@
> -From 768cef60957d5e840071d1d6514d4add3f3c2904 Mon Sep 17 00:00:00 2001
> -From: Naveen Saini <naveen.kumar.saini@intel.com>
> -Date: Wed, 14 Apr 2021 17:25:53 +0800
> -Subject: [PATCH] Makefile: add makefile
> -
> -Current meson build for kernel module build does not fit in Yocto.
> -So added Makefile to build rte_kni.ko
> -
> -Upstream-Status: Inappropriate
> -
> -Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
> ----
> - kernel/linux/kni/Kbuild   |  6 ------
> - kernel/linux/kni/Makefile | 35 +++++++++++++++++++++++++++++++++++
> - 2 files changed, 35 insertions(+), 6 deletions(-)
> - delete mode 100644 kernel/linux/kni/Kbuild
> - create mode 100644 kernel/linux/kni/Makefile
> -
> -diff --git a/kernel/linux/kni/Kbuild b/kernel/linux/kni/Kbuild
> -deleted file mode 100644
> -index e5452d6c00..0000000000
> ---- a/kernel/linux/kni/Kbuild
> -+++ /dev/null
> -@@ -1,6 +0,0 @@
> --# SPDX-License-Identifier: BSD-3-Clause
> --# Copyright(c) 2018 Luca Boccassi <bluca@debian.org>
> --
> --ccflags-y :=3D $(MODULE_CFLAGS)
> --obj-m :=3D rte_kni.o
> --rte_kni-y :=3D $(patsubst $(src)/%.c,%.o,$(wildcard $(src)/*.c))
> -diff --git a/kernel/linux/kni/Makefile b/kernel/linux/kni/Makefile
> -new file mode 100644
> -index 0000000000..19897ee06e
> ---- /dev/null
> -+++ b/kernel/linux/kni/Makefile
> -@@ -0,0 +1,35 @@
> -+#
> -+# Makefile for building rte_kni.ko
> -+#
> -+MODULE_CFLAGS +=3D -include $(S)/config/rte_config.h
> -+MODULE_CFLAGS +=3D -I$(S)/lib/librte_eal/include
> -+MODULE_CFLAGS +=3D -I$(S)/lib/librte_kni
> -+MODULE_CFLAGS +=3D -I$(S)/kernel/linux/kni
> -+MODULE_CFLAGS +=3D -I$(S)/lib/kni
> -+MODULE_CFLAGS +=3D -I$(S)
> -+MODULE_CFLAGS +=3D -I$(STAGING_INCDIR)
> -+
> -+rte_kni-objs =3D kni_misc.o kni_net.o
> -+
> -+ccflags-y :=3D $(MODULE_CFLAGS)
> -+cflags-y :=3D $(MODULE_CFLAGS)
> -+obj-m :=3D rte_kni.o
> -+
> -+
> -+KERNEL_MAKE_OPTS :=3D -C $(STAGING_KERNEL_DIR) M=3D$(CURDIR)
> -+ifneq ($(ARCH),)
> -+KERNEL_MAKE_OPTS +=3D ARCH=3D$(ARCH)
> -+endif
> -+ifneq ($(CROSS_COMPILE),)
> -+KERNEL_MAKE_OPTS +=3D CROSS_COMPILE=3D$(CROSS_COMPILE)
> -+endif
> -+
> -+build:
> -+      $(MAKE) $(KERNEL_MAKE_OPTS) modules
> -+
> -+install: modules_install
> -+
> -+modules_install:
> -+      $(MAKE) $(KERNEL_MAKE_OPTS) modules_install
> -+
> -+clean:
> -+      $(MAKE) $(KERNEL_MAKE_OPTS) clean
> ---
> -2.17.1
> -
> diff --git a/recipes-extended/dpdk/dpdk/0001-meson.build-march-and-mcpu-a=
lready-passed-by-Yocto-21.11.patch b/recipes-extended/dpdk/dpdk/0001-meson.=
build-march-and-mcpu-already-passed-by-Yocto-21.11.patch
> deleted file mode 100644
> index a74869d..0000000
> --- a/recipes-extended/dpdk/dpdk/0001-meson.build-march-and-mcpu-already-=
passed-by-Yocto-21.11.patch
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -From 9aeb0bedf63f0f8f132194705b63ed0045452354 Mon Sep 17 00:00:00 2001
> -From: Naveen Saini <naveen.kumar.saini@intel.com>
> -Date: Wed, 8 Dec 2021 11:48:27 +0800
> -Subject: [PATCH] meson.build:-march and -mcpu already passed by Yocto
> -
> -Upstream-Status: Inappropriate
> -
> -Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
> ----
> - config/meson.build | 12 ++++++------
> - 1 file changed, 6 insertions(+), 6 deletions(-)
> -
> -diff --git a/config/meson.build b/config/meson.build
> -index 805d5d51d0..620331a736 100644
> ---- a/config/meson.build
> -+++ b/config/meson.build
> -@@ -127,12 +127,12 @@ dpdk_conf.set('RTE_MACHINE', cpu_instruction_set)
> - machine_args =3D []
> -
> - # ppc64 does not support -march=3D at all, use -mcpu and -mtune for tha=
t
> --if host_machine.cpu_family().startswith('ppc')
> --    machine_args +=3D '-mcpu=3D' + cpu_instruction_set
> --    machine_args +=3D '-mtune=3D' + cpu_instruction_set
> --else
> --    machine_args +=3D '-march=3D' + cpu_instruction_set
> --endif
> -+#if host_machine.cpu_family().startswith('ppc')
> -+#    machine_args +=3D '-mcpu=3D' + cpu_instruction_set
> -+#    machine_args +=3D '-mtune=3D' + cpu_instruction_set
> -+#else
> -+#    machine_args +=3D '-march=3D' + cpu_instruction_set
> -+#endif
> -
> - toolchain =3D cc.get_id()
> - dpdk_conf.set_quoted('RTE_TOOLCHAIN', toolchain)
> ---
> -2.17.1
> -
> diff --git a/recipes-extended/dpdk/dpdk_22.11.7.bb b/recipes-extended/dpd=
k/dpdk_25.11.0.bb
> similarity index 72%
> rename from recipes-extended/dpdk/dpdk_22.11.7.bb
> rename to recipes-extended/dpdk/dpdk_25.11.0.bb
> index e69a2df..0978004 100644
> --- a/recipes-extended/dpdk/dpdk_22.11.7.bb
> +++ b/recipes-extended/dpdk/dpdk_25.11.0.bb
> @@ -1,17 +1,20 @@
>  include dpdk.inc
>
> -SRC_URI +=3D " \
> -            file://0001-meson.build-march-and-mcpu-already-passed-by-Yoc=
to-21.11.patch \
> -"
> +SRC_URI +=3D " file://0001-config-meson-get-cpu_instruction_set-from-mes=
on-opti.patch"
>
>  STABLE =3D "-stable"
> -BRANCH =3D "22.11"
> -SRCREV =3D "077a7044cc5b2533410f691c8db6fb4f6667b1ca"
> +BRANCH =3D "25.11"
> +SRCREV =3D "ed957165eadbe60a47d5ec223578cdd1c13d0bd9"
>
> -# kernel module is provide by dpdk-module recipe, so disable here
> -EXTRA_OEMESON =3D " -Denable_kmods=3Dfalse \
> -                -Dexamples=3Dall \
> -"
> +def get_cpu_instruction_set(bb, d):
> +    import re
> +    march =3D re.search(r'-march=3D([^\s]*)', d.getVar('CC'))
> +    if march:
> +        return march.group(1)
> +    else:
> +        return "core2"
> +
> +EXTRA_OEMESON =3D " -Dexamples=3Dall -Dcpu_instruction_set=3D${@get_cpu_=
instruction_set(bb, d)} "
>
>  COMPATIBLE_MACHINE =3D "null"
>  COMPATIBLE_HOST:libc-musl:class-target =3D "null"
> @@ -49,7 +52,7 @@ PACKAGES =3D+ "${PN}-examples ${PN}-tools"
>  FILES:${PN} +=3D " ${bindir}/dpdk-testpmd \
>                  ${bindir}/dpdk-proc-info \
>                  ${libdir}/*.so* \
> -                ${libdir}/dpdk/pmds-23.0/*.so* \
> +                ${libdir}/dpdk/pmds-26.0/*.so* \
>                  "
>  FILES:${PN}-examples =3D " \
>         ${prefix}/share/dpdk/examples/* \
> --
> 2.46.2
>

