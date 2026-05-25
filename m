Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E90CD5BB1
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 19:11:10 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22587.1779736264795653847
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 12:11:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=aZhf24Je;
 spf=pass (domain: konsulko.com, ip: 209.85.219.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8c921396e37so101944756d6.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 12:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779736264; x=1780341064; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2keLHY4cXDEBYs/kw0IZxPVuRxiwOJtb6s9NjcpN3bU=;
        b=aZhf24Jen98oNWIh8CpWYBGJ3BdS+iC16kH3lX/2dYaiZYgYAp3vECNjrSEHR8pfhC
         v0ym8rY5rGOAcxGfNyqgvuUCTR7dNTh+6bLgPFg6LSSbjHVqxv1fKmWj7hKAdlcEa4Fq
         VJv/XJAJ9PHrAkddh9TMeyzt+ATJ2tAppxNxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779736264; x=1780341064;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2keLHY4cXDEBYs/kw0IZxPVuRxiwOJtb6s9NjcpN3bU=;
        b=iEeQ6vng/wpZsrKEwvTFsOnkj5nbDWlroLAPfEHCBQEYC74uLSCp375aRmzFzYv5PB
         39eITaUgmys5v/7ObrosqwPHMakSdGa8mKsI90Ua4xYlgA4kumOhfnQI4h/fi0k7M1ab
         LOUFI/kaeJnlGhlmYSkPSuMIzYUaHMYloNDv9L7+Iu/KSTqkRdicoxVCWk7dgoRTib20
         x9IqBEeIu18zMuhssYIgjRRM3/LmyP9unJ386yu44cuulav99SNJ7d1x4qNJ5kYONfhL
         7XyUeKt2xSo0H/0R7KPSmy/cNuP2hfLvAmofHyUs/DJ2mA/5SoDuX4QxqhOgMxvj1/dl
         jIqQ==
X-Gm-Message-State: AOJu0Yy7NReyrbkaWjiW+xYbBQSo63BIpsYIjZlEP2888iJAaGWg2rVL
	g71JQUyO7XPkI6Mlo70bo2Q5Oc+HC7on/qnpT2ftTsdhMTmh0xn8Lg2dq+33maHG+1o=
X-Gm-Gg: Acq92OFZciFyVpB+zk0+EY/scZXMJpzSt+911eaPzPMc+B7teVDqHM/9S6pmL0BSQHS
	zZ8JLcJ+X0FyHKWFP03G4bPqnzMa+/NPYJJHeYvDsVavo53CmxjB3fnBb2FQ197zP1u/OjPw3b6
	tmdt8VxvZw0aIBHo+CmhYTLl5UTqzb5oWBoK9C24M/yw0pAczgvPLxAwL5UZtOwkd6PyQZAQlWA
	RIbDpfgA/v5Yn66xyk2kHwtu/0KnUWxtFArLjJ3jZaiA3UCjSd8RibGAnw04wiHyF/inks6Ue+r
	TJjFtp//pfQk1OB4G/OGRS35RXskvFRyfAuNjLhw90qLMNIxxb6myiU3UnKCFpUWlNopqj+n5+4
	BLMoNsm9Aq6m8ewxxfs+53jU0b0L1J4PyPuAiOQSt+sKdqG/zl6GM262966Y69gKXuycRqKq46j
	J/1tdx6St9bi3PwBwr8OhlgU5bw0GwXtHc/Z40ynNs8S+M4qIQifdEXSql7BqHwQskumBwrvGMt
	yLYG6jUJjHrLgzmYogNfhUlcCZeQGvlJ0h01wLCLAfHz0I=
X-Received: by 2002:a05:6214:2129:b0:8cc:249b:756a with SMTP id 6a1803df08f44-8cc7b5e4998mr266718276d6.38.1779736263514;
        Mon, 25 May 2026 12:11:03 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm116286266d6.38.2026.05.25.12.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:11:03 -0700 (PDT)
Date: Mon, 25 May 2026 15:10:44 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "Marko, Peter" <Peter.Marko@siemens.com>
cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-security][PATCH 00/13] Assorted updates
 05/24
In-Reply-To: <AS8PR10MB507361D4510F0DA1C870E1E8FD0D2@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <3ede33d0-0e65-4d20-8ada-c5c1a1a49136@konsulko.com>
References: <cover.1779624335.git.scott.murray@konsulko.com> <AS8PR10MB507361D4510F0DA1C870E1E8FD0D2@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 19:11:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4048

On Sun, 24 May 2026, Marko, Peter wrote:

> Hello,
>
> Could you also pick following patch to both master-next and wrynose-next?
> May 5 - https://lists.yoctoproject.org/g/yocto-patches/message/3915 - [meta-security][PATCH] tpm2-pkcs11: upgrade 1.9.1 -> 1.9.2

Thanks for catching this, I did miss pulling it into my patch queue.  I
have added it now, and will push it with the rest if the wrynose CI run
looks good (which I expect it will).

Thanks,

Scott


> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.org> On Behalf Of Scott Murray via lists.yoctoproject.org
> Sent: Sunday, May 24, 2026 2:15 PM
> To: yocto-patches@lists.yoctoproject.org
> Subject: [yocto-patches] [meta-security][PATCH 00/13] Assorted updates 05/24
>
> My apologies for the delay in getting this out, this patch series rolls
> up the contributed patches from the past few weeks.  These changes are
> queued on the master-next branch if you would like to check them out to
> test yourself.  I intend to merge these to master branch Tuesday evening
> (CEST, May 26) unless there are objections.
>
> Note that there is one known issue with latest meta-oe that has blocked
> getting clean CI runs that likely will impact anyone using the dm-verity
> bbclass.  The root cause seems to be a new packaging conflict between
> lvm2 and libdevmapper after the recent upgrade in meta-oe, but I have not
> had time to try to dig into it and come up with a clean fix.  I plan to
> look at that if time permits while I am at Embedded Recipes this coming
> week.
>
> Scott
>
>
> Changes:
>
> Anton Antonov (2):
>   parsec-service: Update Parsec service version.
>   meta-parsec: Do not run Parsec CI jobs on 32bit platforms.
>
> Bin Cao (1):
>   samhain: upgrade 4.5.2 -> 4.5.3
>
> Li Zhou (3):
>   firejail: fix COMPATIBLE_MACHINE setting
>   layer.conf: correct WARN_QA
>   aide-base.bbclass: correct STAGING_AIDE_DIR
>
> Peter Marko (1):
>   tpm2-tools: make efivar optional
>
> Ross Burton (3):
>   parsec-service: assign PACKAGECONFIG in one line
>   parsec-service: do group membership modifications in useradd
>   parsec-service: update TS group name
>
> Yi Zhao (1):
>   arpwatch: fix typos
>
> jason.lau (2):
>   google-authenticator-libpam: update 1.0.9 -> 1.11
>   aide: fix pkg_postinst_ontarget shell script
>
>  .gitlab-ci.yml                                |  12 -
>  classes/aide-base.bbclass                     |   2 +-
>  kas/qemuarm-parsec.yml                        |   6 -
>  kas/qemux86-parsec.yml                        |   6 -
>  ...Fix-unnecessary-qualifications-error.patch |  50 -
>  .../parsec-service/parsec-service-crates.inc  | 868 ++++++++++--------
>  ...rvice_1.4.1.bb => parsec-service_1.5.0.bb} |  30 +-
>  meta-tpm/conf/layer.conf                      |   2 +-
>  .../recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb |   5 +-
>  recipes-ids/aide/aide_0.19.3.bb               |   4 +-
>  recipes-ids/samhain/samhain.inc               |   4 +-
>  recipes-scanners/arpwatch/arpwatch_3.3.bb     |   8 +-
>  recipes-security/Firejail/firejail_0.9.72.bb  |   5 +-
>  ...bb => google-authenticator-libpam_1.11.bb} |   4 +-
>  14 files changed, 533 insertions(+), 473 deletions(-)
>  delete mode 100644 kas/qemuarm-parsec.yml
>  delete mode 100644 kas/qemux86-parsec.yml
>  delete mode 100644 meta-parsec/recipes-parsec/parsec-service/files/0002-Fix-unnecessary-qualifications-error.patch
>  rename meta-parsec/recipes-parsec/parsec-service/{parsec-service_1.4.1.bb => parsec-service_1.5.0.bb} (78%)
>  rename recipes-security/google-authenticator-libpam/{google-authenticator-libpam_1.09.bb => google-authenticator-libpam_1.11.bb} (85%)
>
>

