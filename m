Return-Path: <charles.embedded@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F465EF5855
	for <webhook@archiver.kernel.org>; Sat, 14 Feb 2026 21:15:16 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14293.1771103707502563054
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Feb 2026 13:15:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=h16rqIhi;
 spf=pass (domain: gmail.com, ip: 209.85.208.48, mailfrom: charles.embedded@gmail.com)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65a36583ef9so3607176a12.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Feb 2026 13:15:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771103706; cv=none;
        d=google.com; s=arc-20240605;
        b=Lb3+QreJmceHlB2Q2vd+czFFKTWWtJiEZRj7LTDMFeRkxiE0/38Oo+WpF1zo3fbr44
         eRU9sHT7V80MEuXZPFCZ4/DiWPl7GzXe8NCya7F+X7xsvVtbANti4JP+0EdC7cfXgozY
         YT4WVxN9XWyZwoeDR99Y2WuNPQG+d2/n1k7E6inoUQrGZIqYUAefrxsSSZZLy1jiYXtx
         wt8iW4M11X+w/WZK7g2D+SxEqJfenFwIsKEC8kbmpqBFfAhiXm+Zowm/Q2Z1dv8ma4aI
         lex6chOJ0DOxpoRH8FQXKdVHpqZIeNNYByBoRn0W2bEukKURtspofIc9BX11RcgnUZ0O
         Hh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3czT+cxB2GFLDcnC33FEuEu26Hq0ZnrAYjOLIEwThXc=;
        fh=8l7WfZkRcFw3Lcer9YiovPpaEmgz7jp5KSRHZzBA0RY=;
        b=UI2V4IsNgjM3+T1RopNcXOPSCuesUwgQXzWceg14e5y8U2W52GQL1HwJK1pmaiQNxi
         uu4whiwKfp5h0HO3ZiLCCwNJPMebrdC3JjBKmHTZFtXCwYCHJv65+Xms8jBGCzN+DDG4
         LEtwSGHWdnix/pNllysYotvjlO4YIT2mEbA0IjXu1bIghyNXGClpMZhmOzO3hkZQdU/U
         BV1OAnm1KW+7yQYSWAfgXrdt4mngkfwW8mNOUHQGQDooePiOsEdcz1tcZEGT/HBA6iMk
         kb88u9BLc4NJIqrOQ34pW6VO31eaAdgU+KuGjJsqlMdhMsv0o/+cziDNBSkx3n446j4C
         X0Aw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771103706; x=1771708506; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3czT+cxB2GFLDcnC33FEuEu26Hq0ZnrAYjOLIEwThXc=;
        b=h16rqIhiE2tuBxmkPn7xDeq0ZgrlT2fRYV61V43owhdiP8sPa3mQ1CfdYvNZ+3Mcoq
         Ehjia/ZsvvpGwBy3KsUHvyCBML3jaUDSo3feiQ3GTV1cnxoDYnBTOW9HokvexJFBc1V8
         C2eEzm+n4FzEcXrJ/+1XJzEjnFRHTZUEMA2JjoKi6qjT1Hgitl5V95uazggFomDOt8jG
         mMZBh9CVFGWqsGXEbguu4GoSdxTRpxegBvivRRgyDCA62lm/h53uTG24RYiqgEFsj1nV
         v+2uiz5bODiMqRCJZSK/9UiQPjZlaChibU5mWVnmgiwSdnxTzViJvjCIOJH5FNymVpEX
         mDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771103706; x=1771708506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3czT+cxB2GFLDcnC33FEuEu26Hq0ZnrAYjOLIEwThXc=;
        b=uZpKU3/3GMY/Lf29eY0cxgx2A5Tf+Yg5LN26HI64NI4JnhlC2weO0uQtqio6cuEIk7
         4QKmr/DID2lxtCnmeeB/W0EF/pdN+AjoQEuZrbl0WPg6UN74LkkWnezd+h1/KHF4mW3p
         HxltLUjwodI8upa70i4n9VHkB00VX8F4F2QTkM2wUb3Qq2LLYTQhfx0thTVCin3eRtXS
         kyyqXgZiCX5j/vCITYhYT3SZM1YfTlHWGFmco8yTV3oLDvzpm2AaT6d6xW4OfZJuIcd7
         YKdKPrkcFYu9WKFBaMahKb9IYkEk4bsIbqlDqssljMgjAaNMSoL1QzE7F3FsvheX6mQ1
         Fxfw==
X-Gm-Message-State: AOJu0YwFIbSmTkw0RLDABrHbVH7GO/fJTyq72qRwFx6jz3pk2iXwYlaB
	4wbM7+s1QWlCF2DSmW/zBF95CRV6W1tdSTLUgjcb1YTK+ckW9NKNQ4DtS9X/ZvzGJQ7wq8Y3O8U
	v5tm/xPG9iTfrs5AeY6juES/ACpi4Ih8=
X-Gm-Gg: AZuq6aKr8NcKMq6+tZGxmHZbm6n+jAzAffuBFv108k2KOYSjouRPfTmC1XQ6KQaqVie
	h/wF1gv2M/er/m8KYSqEHrzVrR31YwS/9rZbbV1s4GKCJLnFxedHZSbv8jzshX/8i3JguztbIVZ
	qZMOcJEk6y8ll60CIIn5XPS9g7hJCARvM0zC/mnRKJCLhQvydBXzfj0R0VJbBTG2Xn558r4Ui10
	bLDi5hwOIJ5DH2afyshesi173fi+hMI6xGHDdStdD48MloRuusv/fLGzewUSd6zgfmve3QJsLJY
	oHnvHw==
X-Received: by 2002:a05:6402:b11:b0:647:a582:b883 with SMTP id
 4fb4d7f45d1cf-65bc429da2bmr1539449a12.16.1771103705676; Sat, 14 Feb 2026
 13:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20260208164458.101865-1-charles.embedded@gmail.com> <0c7c97d1-bb06-4cda-9917-436ad7209320@amd.com>
In-Reply-To: <0c7c97d1-bb06-4cda-9917-436ad7209320@amd.com>
From: Charles Dias <charles.embedded@gmail.com>
Date: Sat, 14 Feb 2026 18:14:54 -0300
X-Gm-Features: AaiRm52bgRMJIsn_CouP4EMW4_imfXb5MfyQ31Vq5TSjxKtq2uUFGS1eEz2WBAk
Message-ID: <CAHua+AMbsK=Q4Us3t2xSUHW2KRfOPw0tyBLTTuKD=M8Xuzb-QQ@mail.gmail.com>
Subject: Re: [meta-zephyr][master][PATCH] zephyr-qemuboot: use stable ELF
 symlink to avoid broken runqemu rootfs
To: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
Cc: yocto-patches@lists.yoctoproject.org, chee.yang.lee@intel.com, 
	Charles Dias <charlesdias.cd@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 14 Feb 2026 21:15:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3242

On Sat, Feb 14, 2026 at 3:43=E2=80=AFPM Gundlupet Raju, Sandeep
<sandeep.gundlupet-raju@amd.com> wrote:
>
> [Sandeep]: Can you provide me the reproducibility steps for this issue.
> I didn't see this issue when I run the test a month ago.
>

Thank you for your reply.

Please note this has already been merged. For reference, below are the
steps to reproduce the previous issue (before the merge):
1. Revert/remove the merged commit.
2. Build zephyr-helloworld for the qemu-x86 machine:
3. After the build, edit machine/qemu-x86.conf and change any
QB_*/QEMU machine setting, then rebuild:
4. Check bitbake-builds/zephyr-master/build/tmp/deploy/images/qemu-x86/:
zephyr-helloworld-image-qemu-x86.elf is updated to point to a new
timestamped ELF name, but the new timestamped .elf is not present
(broken symlink).

Best regards,
Charles Dias

