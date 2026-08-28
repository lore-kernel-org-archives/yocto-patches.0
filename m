Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896F1C61DB9
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 22:01:37 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32.1787954494886740533
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 28 Aug 2026 15:01:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BC/Ih6GV;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90ccbed6edcso16140036d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787954494; x=1788559294; darn=lists.yoctoproject.org;
        h=content-id:content-type:mime-version:references:message-id
         :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wgCncTONIGBqCX0i2V6uUXTywdR5S3Tp3LHQFsjhdG0=;
        b=BC/Ih6GVN6bnrgWueSJgojL3ZsR2LlMzrgdUq9VkTLQJ1xo8ofJl9xOnCdBM487vzz
         6BSNnzLPA5DUbgEnLRzqb/j1pFsSouibpptENcx5k4308AlrYp9cL1tslbqmhnhUom86
         KEnGkcJd0Nnezta/iCGu0N7NMoLiw10oJM1SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787954494; x=1788559294;
        h=content-id:content-type:mime-version:references:message-id
         :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wgCncTONIGBqCX0i2V6uUXTywdR5S3Tp3LHQFsjhdG0=;
        b=SfTCShv7iKS1Vs5IqQcYfriEKntn39UFq5Y/C6dYKniEDTg28XDByZjjlv2IevB0LN
         SrqWaml0TBerOwGrj6Umhi6ELP+84iMFcWF4IGm4EB7K4arXvnqqF8GymuXs8/62+/5a
         E+akSzz8c7YwjD1S5e+ZGfgI+u2Y+CuSJr4pKRdkKMfzolgd2D5IC7weHFjxJgNGQIKN
         xER7qKuuJTqbEd/0zaTXvDlPGCJB1LppgBLHN0jFqaHV9XBV2Po4Gk8ag/yGUO0JIwxv
         Spbe9H9hYYNZHMnYbvJg2NjxdhVVkz6WDn/f9NHhhSvGzahNXM6+6yXecIq9IMLV8haR
         LWIQ==
X-Gm-Message-State: AFuF++mBrDj8Mie1eS1GjZPI0fAFoiU6lYC3SXerLxEv7mzWsbH84r0g
	eD1s8bGlA5CgcGOBGXl7Z6/Nv7+oUxyOPv4ZMlHcAy7Zn/v2hyxlHq5TUkh8rF6woIvwoWUz6j9
	D1Gn4
X-Gm-Gg: AYBFou2EvioLNNp0ZCzNHi0tHPguPl/K+EU+lZnyLDYqGY618/AMjt4lw3ZxhC9Kkbq
	zdUPZQzB5E2m69RIiNcaf9CynQ01YwtMk5AToTN0/e6+8Rl4q4b/WkSGUK2ujbXH/rLKx8/07t5
	mSC2+7hlsc3SZ8C5l+Yj9NACKLHCMPIMHZCd4Q1GKirWajyid6CbH/nrCHyJsKCRcn79PZYe2de
	6lAY5TXCAtv1hrw5sXdG9j2DOlEW1XLytIM1tj8RiyQYahU/0nC2z1RjIxHOwpY3YtRwNKGgBr5
	sWFJICZu48jUVbM+jP/0vGpwerETZ56wQ713ceSfvHTprHZjmZdumWWqeY/6Ticx3N6V31Z42E/
	H0c/SdpiboJ09P+i8TxvHLRaiPC5l9b2K6AqIb3QkvWlawnYGLgRJ52EFCuAf1KCCqwRBYe9qpD
	MDOpuis0maC3tEm53Yd90kPJD9KrARr9+BvVb9MZS9+WN1HZRiwfkpyxFOvSngYpd6NZTLQxVrK
	2G4JMZELmBBw6Hjv/rAsfNCx8clJxo6objM/B/oV3LSIMnhpUhbULtY3zma/3Cfp5ZAPA5R83Xn
	ksluaRm/xEwTel7hIg==
X-Received: by 2002:a05:6214:4606:b0:907:5cea:2f04 with SMTP id 6a1803df08f44-90ce0e5890cmr138956936d6.1.1787954493527;
        Fri, 28 Aug 2026 15:01:33 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce4512dcasm24587586d6.34.2026.08.28.15.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 15:01:32 -0700 (PDT)
Date: Fri, 28 Aug 2026 18:01:19 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 00/15] Assorted updates
 08/26
In-Reply-To: <18CF768CF3D1C1B6.642712@lists.yoctoproject.org>
Message-ID: <b6c56505-2c52-9848-fb0c-328ec1c1835e@konsulko.com>
References: <18CF768CF3D1C1B6.642712@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811583-1796331030-1787954415=:4042"
Content-ID: <7d52de25-0952-8b9c-7258-ccb3e4eb69a9@spiteful.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 22:01:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4719

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-1796331030-1787954415=:4042
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <506ed5a3-071e-9e13-502c-d411b032272d@spiteful.org>

On Wed, 26 Aug 2026, Scott Murray via lists.yoctoproject.org wrote:

> My apologies for being slow in getting this out, this patch series rolls
> up the contributed patches from the past few months along with some
> other fixes from myself.  These changes are queued on the master-next
> branch if you would like to check them out to test yourself.  I intend
> to merge these to master branch Friday evening (EDT, August 28) unless
> there are objections.  I should have the relevant backports to wrynose
> and scarthgap out for early next week.

These are now merged to master branch.

Scott


>
> Bin Cao (1):
>   samhain: fix server startup failure on systemd-based systems
>
> Esa Jaaskela (1):
>   aide: Fix unstable install task hash
>
> Ga�l PORTAY (3):
>   dm-verity: remove unused variable
>   wic: document the meta-intel dependency in the dm-verity hash example
>   docs: update path of wic files
>
> Krupal Ka Patel (1):
>   tpm2-tools: fix PACKAGECONFIG typo
>
> Peter Marko (2):
>   tpm2-tools: set status for CVE-2017-7524 and CVE-2024-29039
>   tpm2-tss: set status for CVE-2024-29040
>
> Sandeep J (1):
>   README: fix broken URLs in meta-integrity and ccs-tools
>
> Scott Murray (4):
>   aide: Fix compilation with nettle 4.x
>   suricata: handle oe_cargo_build removal
>   meta-integrity: Fix ima-evm-utils LICENSE
>   meta-tpm: Fix SUMMARY/HOMEPAGE in affected recipes
>
> Shreejit C (1):
>   meta-tpm: Add missing recipe metadata (HOMEPAGE/SUMMARY)
>
> Wang Mingyu (1):
>   fix LICENSE variable syntax to suppress QA warning
>
>  classes/aide-db-init.bbclass                  | 11 +++-
>  classes/dm-verity-img.bbclass                 |  1 -
>  docs/dm-verity-systemd-x86-64.txt             |  6 +--
>  docs/dm-verity.txt                            |  2 +-
>  .../wic/systemd-bootdisk-dmverity-hash.wks.in |  1 +
>  meta-integrity/README.md                      |  4 +-
>  .../ima-evm-utils/ima-evm-utils_1.5.bb        |  2 +-
>  .../recipes-core/images/security-tpm-image.bb |  2 +-
>  .../images/security-tpm2-image.bb             |  2 +-
>  .../packagegroup/packagegroup-security-tpm.bb |  2 +-
>  .../packagegroup-security-tpm2.bb             |  1 +
>  meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb |  1 +
>  meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb    |  1 +
>  .../openssl-tpm-engine_0.5.0.bb               |  2 +-
>  .../tpm-tools/tpm-tools_1.3.9.2.bb            |  1 +
>  .../tpm2-abrmd/tpm2-abrmd_3.0.0.bb            |  1 +
>  .../tpm2-openssl/tpm2-openssl_1.3.0.bb        |  1 +
>  .../tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb          |  1 +
>  .../tpm2-pytss/python3-tpm2-pytss_2.3.0.bb    |  1 +
>  .../recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb |  6 ++-
>  .../tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb  |  1 +
>  .../recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb   |  3 ++
>  .../0002-Support-build-with-nettle-4.patch    | 53 +++++++++++++++++++
>  recipes-ids/aide/aide_0.19.3.bb               | 14 ++---
>  recipes-ids/crowdsec/crowdsec-licenses.inc    |  2 +-
>  recipes-ids/crowdsec/crowdsec_1.7.7.bb        |  2 +-
>  ...-set-SetLockfilePath-to-run-yule.pid.patch | 41 ++++++++++++++
>  recipes-ids/samhain/files/samhain-client.init |  3 +-
>  recipes-ids/samhain/files/samhain-server.init |  3 +-
>  recipes-ids/samhain/samhain.inc               |  1 +
>  recipes-ids/suricata/suricata_8.0.4.bb        | 11 ++--
>  recipes-mac/AppArmor/apparmor_4.0.3.bb        |  2 +-
>  recipes-mac/ccs-tools/README                  |  2 +-
>  recipes-perl/perl/lib-perl_0.63.bb            |  2 +-
>  recipes-perl/perl/libwhisker2-perl_2.5.bb     |  2 +-
>  recipes-scanners/clamav/clamav_1.4.4.bb       |  4 +-
>  recipes-security/libgssglue/libgssglue_0.9.bb |  2 +-
>  37 files changed, 159 insertions(+), 38 deletions(-)
>  create mode 100644 recipes-ids/aide/aide/0002-Support-build-with-nettle-4.patch
>  create mode 100644 recipes-ids/samhain/files/0013-yulerc-set-SetLockfilePath-to-run-yule.pid.patch
>
>
---1463811583-1796331030-1787954415=:4042--

