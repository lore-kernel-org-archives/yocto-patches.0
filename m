Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10554D65543
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:37:36 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11840.1765967849433176730
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Dec 2025 02:37:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=s7irv5Rq;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 787154E41C57
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Dec 2025 10:37:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 48F1A6072F
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Dec 2025 10:37:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A34EE119527C3;
	Wed, 17 Dec 2025 11:37:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765967846; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=3hIAIDm8FGEAoNPi8CVcmLf88Vpl9AZrdlR7ac1skZY=;
	b=s7irv5Rqsa1nYF8rQIqKROwPam5TFfE4+WoyQD4ez3QWet0mhjjVNMZ62muzWByHGMAT0l
	aGIRmvj5BBLrMP7dD4mGijq8cH5tlBNmDuY6KKg2sgt46xMDTGB7DB/7X4c+dTh8XfiLe6
	7UDdz7iXjVUXTBHMFuu2QQGAZv6rjq6qxjjM5SkfNLpicA9/BbYTIKDYOxJFhduUMP9jYj
	/3ygM0FbpNKbympd/DVYYx+zchvSzEXm5Z40ZmnUMptJaCWZ3C/XJHx6uKTHUqm8L7Sakg
	KLCFspJ/QRThvv6MJ9d1t/eungWvYlGWm20JexNFQMpm/kzjqYSmxIkkjQcAnQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 17 Dec 2025 11:37:13 +0100
Subject: [yocto-autobuilder-helper][PATCH] scripts/run-docs-build: update
 buildtools docs tarball to 5.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-update-buildtools-tarball-v1-1-2e3e3db2a0a0@bootlin.com>
X-B4-Tracking: v=1; b=H4sIANmHQmkC/yXMTQ7CIBBA4as0s3YSwGCsV2m64Ge0GFLIAEbT9
 O5iXX6L9zYoxIEK3IYNmF6hhLR2yNMAbjHrgzD4blBCaSnOElv2phLaFqKvKcWC1bA1MeJVayW
 k8ZdRjdD7zHQP7+M9zX+XZp/k6m84fZKrCU2r6XgR40IxE8+w719dRQlClwAAAA==
X-Change-ID: 20251031-update-buildtools-tarball-855201ad6929
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=pH1Gd3kt17/NnDTMEJrbbtX9wccM0MZIekVCjBwhhFI=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpQoflOIUKSqhJDhApgOdQG3klrD4zIqbAB42JZ
 GLtimPG6lmJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaUKH5QAKCRDRgEFAKaOo
 Nh1pD/9AfTT3L+dyTXBCnvNdVdozNFLn0NyzDo7NiE1ZjpfJbJ/A6pUPfdmCe2ZVK1vJLtIgZzh
 JjlXWhuziizB67PcBamiYSFp+JAyku7GeoEwSnW5rqcW5hEN46Yuze8U6MdSEp2qVOi4ZPsqUH2
 mbFVcjqrsU3anjsvW1OwdcQqDpOEXnvkIwSlU2m+/HHRLgk992UUs2YukXasG/TRIekMTxS1E3U
 17MDuQktBgTcGePlP53ShbsoKsV62+Vi9BuWfsHNoxCAncOHSwv0QTKdhlmuh0a8xGAKFIND07U
 Dj5YzkfPNYIS7vyAV1pMVZr1dJINnBpZMN2fej2KUSPBSseH1tnHoJA7zWjTv4EXeGz85J5j3Xq
 h9usY49Z/rnjKWNXHPtUDqWwjWjaxCGhD4NO2BiFwSTQAHyqFXiUYmGPg1bS6uTv91t1xwik6hZ
 yBzBBuyPgr4R32dGtbsZpRQBTmqREXcmJJ7ZpEVntbswtxGDkV+E5iOgWwWnP5zGHub3qcZM1Dz
 ZjHDLznIJ95Nyze3kvhtgMkr+4FU4vS4pWeOTcEbt+wAajWfDnJBXD2HvfwBoUHUZak6btYxQn8
 Zg1rCWrZRWnBDF+C8u0CiFhW1+63OPfNXqA3g39fnQbyKwyQxL8HUaZ2YRp6HZBBr23ZiLnEbqk
 MqjuaN/rVQBBTrA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Dec 2025 10:37:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2811

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index a001fb2..b83799a 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -26,7 +26,7 @@ scriptdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
 PUBLISH=${PUBLISH:-1}
 sharedir=`jq -r '.["BASE_SHAREDDIR"]' < $HOME/config-local.json`
 # Modified 5.1 tools image to include rsvg, switch to next released version
-buildtools_url=${buildtools_url:-https://downloads.yoctoproject.org/releases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-5.1-modified.sh}
+buildtools_url=${buildtools_url:-https://downloads.yoctoproject.org/releases/yocto/yocto-5.3/buildtools/x86_64-buildtools-docs-nativesdk-standalone-5.2.99%2Bsnapshot-8519978592483bb096ed5192fff7af6c887b799e.sh}
 buildtools_url_old=${buildtools_url_old:-https://downloads.yoctoproject.org/releases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-4.1.2.sh}
 docbookarchive_url=${docbookarchive_url:-https://downloads.yoctoproject.org/mirror/docbook-mirror/docbook-archives-20201105.tar.xz}
 

---
base-commit: bb28c344660afc88a7a4c1edf8847041728a6654
change-id: 20251031-update-buildtools-tarball-855201ad6929


