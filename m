Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A41D3517E
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 13:21:10 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13036.1775049664334664831
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Apr 2026 06:21:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ZEGzh9bP;
 spf=pass (domain: gmail.com, ip: 209.85.167.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a279ce9475so1018576e87.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Apr 2026 06:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775049662; cv=none;
        d=google.com; s=arc-20240605;
        b=G4wPLXF9Xk4Cwh9K8k4LlzGZAzYg7OdDOF3Php9DdrbOEeuWxaUdhoDUfUS7Vuei/k
         xOMvC0MJgnJ5GFjl9jCBG8TB5aywYJUg7G9kNS/QqC0SXdoz7fQLZVrHKQu4+F6A3pED
         0bJrGSQCoiREhCUti+gARDmwy4hgr2BerS43kr51FE4LRoy0gRcFW9bsgAJeXK1C+vhy
         wRjwIWtLveAbFDqlTeCCeHNE5MHkUNmz5vAWQyPe+eHSQ33TvUrt2GQUHq3UlnKt7H8Q
         LFCmmGnbYyi/5KTBFBLTKvkwWZRBmKZk1y4hBcDiIcI6ZH82UBnu1Zp5sAJZIk9sE6WF
         5YSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j2vjJ4u7YS6RAvUB3QpjEne7I5hkObFF4ItvG2JKcZo=;
        fh=RTkyzoiqblVhgEJsCuNYhsna0iEHGBcVxJL5KX48Uz8=;
        b=AQVOro41J/2EhQjphKTaWg7TRGTShSUXXQccw9oeuVS7cJDCCKYR89aohcYLY6QXTe
         KbQd6W+NaMLeDc1pVvt6YNuDFPB4q2khq0LzrMIEmsFB4bVUL66zZWVzquAnU4xFUefF
         ETY5zPznFniocsMgl9218AFCXHfCNFC5mT76xS7aRsm9crZ1BpBquhys9kQBCZ+/aUSG
         ZSMkFCEP7PTw4akORMfwBT62BacjlQfTL4VvfWvbFGXbmaFVsYexWpSu3AMtxzF32kVQ
         JBNA1wwiMG1iYo6gnJhK+FgmDphJxxuax4NsN5+4+wPPn97zpSgupygDGJrsDJRYjzju
         d5KQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775049662; x=1775654462; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2vjJ4u7YS6RAvUB3QpjEne7I5hkObFF4ItvG2JKcZo=;
        b=ZEGzh9bPBcaS4s0rEz6I3632LrOJpxP31QO8wvMWQGDhKzbIbwHXiq4c5ggQ7YDbbm
         fqMBJpYo2kRq+R87GCcCRulBln3RDEeN8xMOYJVh23cM1RcolzeOVWM86gsdHVQ444BU
         XDFgkx8rMfTKlRA9e/ECy3NqCwwPPFAuOQ6T2QhcACQ4kAWd0Xe9vNzJlx85XTc9Vn/G
         6XLcY/ysjm0a+vYp3+keEZ9F7njLAGsXVPW2MdCXS4uDDmqwAXZashK766krojZ+fseD
         AAdjV2T4PyuoOyVx7Ls5FnmoD4owBKNbI3/VGwIjOKH/AKypKb2rlijDrcL+05j8I2s9
         xwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775049662; x=1775654462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j2vjJ4u7YS6RAvUB3QpjEne7I5hkObFF4ItvG2JKcZo=;
        b=ZEAq/thfkcd/lFBP4RxoIXOyn2cKHBIeFnVGK8pr02sLso/7lMbElOzhmRbrVC0MJs
         jLzXi4hymCrPCF6ojMnNYKiJ3uTog6tba0Go4QpbnC5xu1iYPpZcu1uuuyde9D0I0De/
         UhrLbMAxGHN5vg3mGYPV7lLPyXGfLjtHrhRzDaL0xTTDpY9Xtjx1iTzm/nBEteaEQDXM
         IcOYGW2PLWUo8YO8tbis6k812YoFtAVt3azn4V8VcU9dVuqN4N/fQWAgC2zr3/hfO/vL
         dm9/Pp7gffQAdWKPE5/E58Mqs8drv7C0vAY+LAgMBwiWGzbvxYCJmwFzS2Hw9rjuWJVS
         EGlA==
X-Gm-Message-State: AOJu0YyLA6s4LHrt7MiBKUgWYhrcTgDJpMNa8rUdn7p/PVvN8etzjYQ0
	4LVQKMKdfEjyzfrQ/dJM4xT7N2R0bW7aIbPdWH6iQ4LYZiT8dWY+sBhCKJBejaGnE7NX9vMGPZv
	Qv3Z2nVmzbgDmsYBVN4kugMi88FLo/UiyWbNG
X-Gm-Gg: ATEYQzzUt0g2Ntk+1eCvelYZ9Egx9bUNGyAsew+whSrQt3Lht8bTnzKaYMLm7oQJHUm
	so1J4fWwNFaIabCMRGUg04L5Kd6m+/7HWkg/CiQt3wQxoLADwfllrUcOz459W3ftKbetBXudkqM
	m2N/8FqiLimPptliTpIYHclPUotj/6+Jqno8L/jNwizg2TDTADJ4UoZ8iA2I/HAFJnmld19OZe3
	9Ch/ILgWGUxhYmi01HZ88viQRTKq2LyDnRYLW9G1NAEJj5Mz6whHHQ3DbmRDX0CVpQu56LG5eiq
	VS+957pY1w==
X-Received: by 2002:a05:6512:a8c:b0:5a2:b259:5569 with SMTP id
 2adb3069b0e04-5a2c220464bmr1131926e87.15.1775049661694; Wed, 01 Apr 2026
 06:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260401053022.96757-1-martin.jansa@gmail.com> <9d3a3b8c-2b03-41ed-8ac9-49ae7ec174a6@windriver.com>
In-Reply-To: <9d3a3b8c-2b03-41ed-8ac9-49ae7ec174a6@windriver.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 1 Apr 2026 15:20:47 +0200
X-Gm-Features: AQROBzA4OSVxb5pn1z0SrTzb7CQ_s_eJUl8XEejXGH0Xc48erJeiaJpWsa1WO3Y
Message-ID: <CA+chaQfQg0Wo0emSgeyjEgqJ4TYvOmRGZykNQmYjMr-FwdCC_A@mail.gmail.com>
Subject: Re: [meta-tensorflow][PATCH] tensorflow-lite: don't install
 flatbuffers header files
To: Hongxu Jia <hongxu.jia@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Apr 2026 13:21:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3595

On Wed, Apr 1, 2026 at 7:34=E2=80=AFAM Hongxu Jia <hongxu.jia@windriver.com=
> wrote:
>
> On 4/1/26 13:30, martin.jansa@gmail.com wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
> >
> > From: Martin Jansa <martin.jansa@gmail.com>
> >
> > https://lists.yoctoproject.org/g/yocto-patches/message/2186
> > breaks a build for recipes which depend on both tensorflow-lite and fla=
tbuffers because of conflicts in RSS as in:
> > ERROR: foo-1.0-r0 do_prepare_recipe_sysroot: The file /usr/include/flat=
buffers/array.h is installed by both tensorflow-lite and flatbuffers, abort=
ing
> >
> > Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> > ---
> >   recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb | 7 -------
> >   1 file changed, 7 deletions(-)
>
> Merged
>
> //Hongxu

Thank you for quick update.

With newer ubuntu on host I'm seeing one more issue with bazel-native,
will send a patch or more details when I figure out what's wrong, but
it fails with ubuntu-25.04 and newer while in ubuntu-24.04 and 24.10
it built bazel-native fine.

I'm sharing it now just in case you've already seen this issue and
might have some pending fix already.

The log from 24.04 doesn't show "Linking src/main/cpp/util/libport.a"
at all, so I guess it's util:port dependency somehow not required, but
I'm still searching why (in all that bazel output which is a bit
confusing to me :)).

Regards,

tmp/work/x86_64-linux/bazel-native/7.7.0/sources/src/main/cpp/util/BUILD:95=
:11:
Linking src/main/cpp/util/libport.a failed: (Exit 1): ar failed: error
executing CppArchive command (from target //src/main/cpp/util:port)
  (cd tmp/bazel/bazel_EExPgtfN/out/execroot/_main && \
  exec env - \
    PATH=3Doe-core/scripts/native-intercept:tmp/work/x86_64-linux/bazel-nat=
ive/7.7.0/recipe-sysroot-native/usr/bin/python3-native:oe-core/scripts:tmp/=
work/x86_64-linux/bazel-native/7.7.0/recipe-sysroot-native/usr/bin/x86_64-l=
inux:tmp/work/x86_64-linux/bazel-native/7.7.0/recipe-sysroot-native/usr/bin=
:tmp/work/x86_64-linux/bazel-native/7.7.0/recipe-sysroot-native/usr/sbin:tm=
p/work/x86_64-linux/bazel-native/7.7.0/recipe-sysroot-native/usr/bin:tmp/wo=
rk/x86_64-linux/bazel-native/7.7.0/recipe-sysroot-native/sbin:tmp/work/x86_=
64-linux/bazel-native/7.7.0/recipe-sysroot-native/bin:bitbake/bin:tmp/hostt=
ools
\
    PWD=3D/proc/self/cwd \
    ZERO_AR_DATE=3D1 \
  oe-core/scripts/native-intercept/ar
@bazel-out/k8-opt/bin/src/main/cpp/util/libport.a-2.params)
# Configuration:
d26135a3254147264e37dd42dcbe81f92695ccaa36573733091ed4b195d3bf62
# Execution platform: //:default_host_platform
oe-core/scripts/native-intercept/ar: invalid option -- '@'
Usage: oe-core/scripts/native-intercept/ar [emulation options]
[-]{dmpqrstx}[abcDfilMNoOPsSTuvV] [--plugin <name>] [member-name]
[count] archive-file file...
       oe-core/scripts/native-intercept/ar -M [<mri-script]

