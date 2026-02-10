Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD44EA810E
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 13:07:04 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19145.1770728814188203279
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Feb 2026 05:06:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=zGCOieC/;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 11B654E40BE3
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Feb 2026 13:06:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DC135606BD
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Feb 2026 13:06:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EDB92119D0B2E;
	Tue, 10 Feb 2026 14:06:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770728811; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=CtGRsR2/kR0MocfefS5IFNTG7EbG3Z169pCgjL8hr/4=;
	b=zGCOieC/S7zeZDtBSolRuMX5Io3Sn/6DynwiBNNZjRZ9EnpAVqpYJcZc3GqZcbI+i9GOR+
	JHS6HkBOlvpok3EVC0GzcWu0/xuhOiYq8s270pbfBVaumsH7WSqui/MyB3hSWrft9Mo4Zn
	2UwJNyVz9rvvLsJpAMH6bnGG/mmlp0ddj7Oi/tohZZF1+bDeuCDq+k7stup5wSMjkvVpZx
	QAdGxzqrDLRdjQ0Lb9rD3QnQVgrASwR5nL8tYKjkzfl9aH3dmwkROTtdF3tMEFlQpy1tJR
	xcl4Hht746QXo/WzlcPzkC2jKDN+STV8h5zzVfkomFIx/j6OmzZN8OnV6ZT4eQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 10 Feb 2026 14:06:47 +0100
Subject: [yocto-autobuilder-helper][PATCH] scripts/run-docs-build: update
 buildtools docs tarball to 6.0_M1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-update-buildtools-docs-v1-1-1be3664c0d29@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywrCMBCF4Vcps3YgDSWir1K6SJPRjoROyKUop
 e9urMsfzvl2yJSYMty7HRJtnFnWFv2lA7fY9UnIvjVopY3SvcIavS2Ec+Xgi0jI6MVlvN6GNrC
 GBjLQzjHRg98nPE7/znV+kSs/bfyIK4K2FjkhSrhQiJQmOI4vmdVOzJQAAAA=
X-Change-ID: 20260210-update-buildtools-docs-794260a6e4e6
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=7fPCsOt/wtnnWMKv3hR8AZEgq+0N+M8+Q7atE1MCUCQ=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpiy1qdHCSJrgQ/to8veybm6Aupt+At11bbLN2b
 hheS/nB8T6JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYstagAKCRDRgEFAKaOo
 NmN3D/904kyZpxCOkzCv8z67zX81ZmHDGXn1LjoiNlsyEIumAxhyJWJN6O2Fepj1ENWelRYLRPm
 afziVFzcd3SAhNPEmAfCQ7msqEtkGaGr5ACsbNP4QjtZBrgpfRCy4UeF2Fbtggcrk7BM+xfSJev
 KuQcv9l1d7D5u4pt35YDvVK1WeMbRThP+ksIjhYpc2fq6jSByknZlN9sNbWXvgJ4dcaRxdCtih1
 baFePydTxqK5BDzETauv1BsQ6N5h18JxpwULHM9JQQIqK9UU/SsQx6VdnooZEdm3fGj4o4q7NwY
 PPp/iHFlCDruF5bW/RjUvEItPHXpDqZ6K64zVXUo1Qey7b/WO/AIV7lbrmVq9ht3iZewIiBlvlo
 8Uz52bul1kl9szmzQtKjxhFTHW+ibwhaQqM4g7IqueTzJHmPvM7p+bL5lyLME9lxK9cEYYuEj24
 ll60fZcNQOZdTA/gsYIncfuSw7gy0Kz6OQuD9I9oHCMQkevUo5HtjMLLRHT0m7Lir6YCWX2DOD6
 E3tgNmUdp/Ki1VstRpqOUxrSs2Kn16emP5zyQjf/ZpPMNqxj43JAO5g6eIIB0/iiG+bkvvJoYLS
 hwKG1mJ2KlDvFCC9K138bPXBeirwjttZqaTj6MzvCE8dbvxAEMAmCf2Yt8wcyV5ioW0bM7570rT
 f3pFMkER4gWbaDA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Feb 2026 13:07:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3210

Update the buildtools tarball to 6.0_M1, which contains the recently
added python3-sphinxcontrib-svg2pdfconverter. This should help up
proceed with the changes suggested in [1].

[1]: https://lore.kernel.org/r/20251202-fix-make-multi-target-v2-1-7eea1d64cf6b@cherry.de

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index b83799a..7c16470 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -26,7 +26,7 @@ scriptdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
 PUBLISH=${PUBLISH:-1}
 sharedir=`jq -r '.["BASE_SHAREDDIR"]' < $HOME/config-local.json`
 # Modified 5.1 tools image to include rsvg, switch to next released version
-buildtools_url=${buildtools_url:-https://downloads.yoctoproject.org/releases/yocto/yocto-5.3/buildtools/x86_64-buildtools-docs-nativesdk-standalone-5.2.99%2Bsnapshot-8519978592483bb096ed5192fff7af6c887b799e.sh}
+buildtools_url=${buildtools_url:https://downloads.yoctoproject.org/releases/yocto/milestones/yocto-6.0_M1/buildtools/x86_64-buildtools-docs-nativesdk-standalone-5.3.99%2Bsnapshot-6c31c2a731858108e790acaf38679a01b0d1a035.sh}
 buildtools_url_old=${buildtools_url_old:-https://downloads.yoctoproject.org/releases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-4.1.2.sh}
 docbookarchive_url=${docbookarchive_url:-https://downloads.yoctoproject.org/mirror/docbook-mirror/docbook-archives-20201105.tar.xz}
 

---
base-commit: ec17abb0b2d759b800cefec4fcac61cee74dbefc
change-id: 20260210-update-buildtools-docs-794260a6e4e6


