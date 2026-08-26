Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C144C5DF97
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:58:52 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22423.1787777924544400225
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HkvgmGb9;
 spf=pass (domain: konsulko.com, ip: 209.85.219.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-90ccbed6edcso11038046d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777923; x=1788382723; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0l1qHj/6Bi79SeZif2s/mfZuHJHbBa/7pUiganM2FI=;
        b=HkvgmGb9ea5aY9tAyUaNeGs7t/IiDwC6YDGNsLj1cDZp51ggRMMzWnG4U+2axCniyS
         oLUWokKfVK17XjIU9P8QPcEVhXEtSkG3MECyZG8VsQg8OJ2ZFbXUnHinRtLvQbPVN+IO
         RNBx5DaHgwfjfEb44Xf/g7xOSkaF2qUiRR3ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777923; x=1788382723;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x0l1qHj/6Bi79SeZif2s/mfZuHJHbBa/7pUiganM2FI=;
        b=jRAEVCmCClv/OxuFN5FJxP2Whfkw31kETp874+aKNw2Yhh66l9h8jXFVpX5icMsdSL
         wYE3746FGCHn2uGBnJVCcHiywZZdrW81dcmt5ZU2xIKQ1WBt2ef3J8SbHG2VFO1/9bsh
         BMCyCwOvv4IiKsyn1dFIFHTRjo9Uxw8u1kxyydACQgG4otBUUJkyJRu6pfwbQEt5J39y
         3OyEEYISC+nLOjhb+xAVZsGHKrTMcl5vfHeEQcy879bjohiTPFUKLHS0AbB2PhsDjCaa
         h5FZTpIFGs/Jj1H8LodBF/o8pFj5QtZpnr6NsAbRDFG7b6dlo5oukueUImn7lAej76zP
         4Y+A==
X-Gm-Message-State: AFuF++meeXdIy/N5ylcBeCwJSlRcEOqW2+956x20aO3NV5T8f5lz8Im9
	gaDEY/YzNhZFffg4LXhfTIIHq1JjTlYoobhwARr3dmJsbgzqEqlU2+uObHZRw43MtTQp4AvmA/j
	oAHP0
X-Gm-Gg: AR+sD10x5HZJtBGoVDE3TCwctWoslk4oP709jHIovvPyoQOv/uB68xQgQKOPTOK59h9
	Fw1pEdD5+9V727/0ALXLg854fZ2tUTzEIsYe5BXRxSckmIye86Vyte7vSGiUQHFdsQfKWrch21m
	VgW2pLiHD9NsPGvkjGtlwDklntsREMssmYhQFwFqPUiHjHqrwtldzkAtWPDX2Yr/SNpXuQ/Lyu0
	QCm4YYagvcRdZ6fzp6afKkVKRMPqhuoWr5PV0tCc6LRaYTh0GE05GljuDDZZjQ5DVRF+LEDvqsR
	avS0WrBsM5hX15OTTpB3UKtRXmqiZmgmrPXBLuObOJF800le9GQlBwTIqtQ03ud7vwq8BHb2BOG
	/tar34re31CDDw27cwsYORPWsbnpaGaSrI//rYXf0NlBTZrpKmNplfhamYqH+jfcUStdsKjuhrT
	2gR8DlYBgRIvrOVw2qCT1wHXlQxeCJ0Hlpi/jkNm6VwbTyFrzTTqGECM8/P/X1p2Jp3QQZI+C0D
	c69hFwDBAupLeRSOO88e8ThPaWqIxqjkwJkaESVofSTyxWOrlWQiaiSIz6Z/ksAnSJ46I9JlxkP
	/+BH9YFGkuzBXv2WkG/jYu2XgA==
X-Received: by 2002:a05:6214:4605:b0:8ee:d9e7:be2d with SMTP id 6a1803df08f44-90cc79308d8mr117615096d6.7.1787777923166;
        Wed, 26 Aug 2026 13:58:43 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:42 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 00/15] Assorted updates 08/26
Date: Wed, 26 Aug 2026 16:57:34 -0400
Message-ID: <cover.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:58:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4692

My apologies for being slow in getting this out, this patch series rolls
up the contributed patches from the past few months along with some
other fixes from myself.  These changes are queued on the master-next
branch if you would like to check them out to test yourself.  I intend
to merge these to master branch Friday evening (EDT, August 28) unless
there are objections.  I should have the relevant backports to wrynose
and scarthgap out for early next week.

Scott


Bin Cao (1):
  samhain: fix server startup failure on systemd-based systems

Esa Jaaskela (1):
  aide: Fix unstable install task hash

Gaël PORTAY (3):
  dm-verity: remove unused variable
  wic: document the meta-intel dependency in the dm-verity hash example
  docs: update path of wic files

Krupal Ka Patel (1):
  tpm2-tools: fix PACKAGECONFIG typo

Peter Marko (2):
  tpm2-tools: set status for CVE-2017-7524 and CVE-2024-29039
  tpm2-tss: set status for CVE-2024-29040

Sandeep J (1):
  README: fix broken URLs in meta-integrity and ccs-tools

Scott Murray (4):
  aide: Fix compilation with nettle 4.x
  suricata: handle oe_cargo_build removal
  meta-integrity: Fix ima-evm-utils LICENSE
  meta-tpm: Fix SUMMARY/HOMEPAGE in affected recipes

Shreejit C (1):
  meta-tpm: Add missing recipe metadata (HOMEPAGE/SUMMARY)

Wang Mingyu (1):
  fix LICENSE variable syntax to suppress QA warning

 classes/aide-db-init.bbclass                  | 11 +++-
 classes/dm-verity-img.bbclass                 |  1 -
 docs/dm-verity-systemd-x86-64.txt             |  6 +--
 docs/dm-verity.txt                            |  2 +-
 .../wic/systemd-bootdisk-dmverity-hash.wks.in |  1 +
 meta-integrity/README.md                      |  4 +-
 .../ima-evm-utils/ima-evm-utils_1.5.bb        |  2 +-
 .../recipes-core/images/security-tpm-image.bb |  2 +-
 .../images/security-tpm2-image.bb             |  2 +-
 .../packagegroup/packagegroup-security-tpm.bb |  2 +-
 .../packagegroup-security-tpm2.bb             |  1 +
 meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb |  1 +
 meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb    |  1 +
 .../openssl-tpm-engine_0.5.0.bb               |  2 +-
 .../tpm-tools/tpm-tools_1.3.9.2.bb            |  1 +
 .../tpm2-abrmd/tpm2-abrmd_3.0.0.bb            |  1 +
 .../tpm2-openssl/tpm2-openssl_1.3.0.bb        |  1 +
 .../tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb          |  1 +
 .../tpm2-pytss/python3-tpm2-pytss_2.3.0.bb    |  1 +
 .../recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb |  6 ++-
 .../tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb  |  1 +
 .../recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb   |  3 ++
 .../0002-Support-build-with-nettle-4.patch    | 53 +++++++++++++++++++
 recipes-ids/aide/aide_0.19.3.bb               | 14 ++---
 recipes-ids/crowdsec/crowdsec-licenses.inc    |  2 +-
 recipes-ids/crowdsec/crowdsec_1.7.7.bb        |  2 +-
 ...-set-SetLockfilePath-to-run-yule.pid.patch | 41 ++++++++++++++
 recipes-ids/samhain/files/samhain-client.init |  3 +-
 recipes-ids/samhain/files/samhain-server.init |  3 +-
 recipes-ids/samhain/samhain.inc               |  1 +
 recipes-ids/suricata/suricata_8.0.4.bb        | 11 ++--
 recipes-mac/AppArmor/apparmor_4.0.3.bb        |  2 +-
 recipes-mac/ccs-tools/README                  |  2 +-
 recipes-perl/perl/lib-perl_0.63.bb            |  2 +-
 recipes-perl/perl/libwhisker2-perl_2.5.bb     |  2 +-
 recipes-scanners/clamav/clamav_1.4.4.bb       |  4 +-
 recipes-security/libgssglue/libgssglue_0.9.bb |  2 +-
 37 files changed, 159 insertions(+), 38 deletions(-)
 create mode 100644 recipes-ids/aide/aide/0002-Support-build-with-nettle-4.patch
 create mode 100644 recipes-ids/samhain/files/0013-yulerc-set-SetLockfilePath-to-run-yule.pid.patch

-- 
2.55.0


