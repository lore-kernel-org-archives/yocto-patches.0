Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5540.1793784745787932965
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 01:32:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=BdZjt3HH;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E9F094E413F6
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Nov 2026 09:32:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B7F5A60770
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Nov 2026 09:32:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 233A1103291FD;
	Wed,  4 Nov 2026 10:32:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793784743; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WVLaWHrON22VTIEutqPKsB5i2Sq2wkN2+9h5IqeER3s=;
	b=BdZjt3HHo0QAKjCNj1OTP4a6hkfZ9jckCzfJZz3LCF315EwozmR53UPDvk2JTVMUjHtddW
	Ub1+eMtQEj21d9Fo0CkWac5xGSaT3qX7+7KRgp15lNQkAWVIeX65Vkf5plPXoNj3SH3I0W
	w8wberDbYfogRsBngpFRE7WZgXlrKVLxMVqEw/Jz9QOb3mYK5APOcYwWuFk4xt6XrHzLEW
	CGMV9Btut/bZ9OIQXLPyLwqNzyiWDlRnHdEVSzmVWj4vRvcxA3YgSykNPpA13eIKA8TZMM
	8UfyKqC0NsKhnZ1dfAdyAuqVhnhYOEJc1tg6gwuQKoKxTG6TESKx+cB4zCqnQA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 04 Nov 2026 10:32:12 +0100
Subject: [PATCH yocto-autobuilder2 1/5] docker: Use https instead of git
 protocol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-mathieu-release-selector-fix-v1-1-a245895c0093@bootlin.com>
References: <20261104-mathieu-release-selector-fix-v1-0-a245895c0093@bootlin.com>
In-Reply-To: <20261104-mathieu-release-selector-fix-v1-0-a245895c0093@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793784741; l=894;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=A3iZ/WYMtCz0eYEDevGJh1cWxscKDut86ZPS9vX3Vyw=;
 b=QfbcKzMe7ZNKdpULgJKLW96i0OcVvCDywqbhrdUwewyucWUizHtuBS0AX+c5gzkpNAoLP5Tio
 vmeUMDaqT1eApKhbJ6eWAci7qAYsnywgh9mpZMd0zoltuJeDNbRuCfn
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 09:32:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5226

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 docker/Dockerfile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docker/Dockerfile b/docker/Dockerfile
index 793343a26017..361d409f990c 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -115,8 +115,8 @@ RUN sed -i \
         -e '$ a workers_prev_releases = {}' \
         /home/pokybuild/yocto-controller/yoctoabb/config.py && \
     sed -i \
-        # Use git protocol instead of ssh
-        -e "s#ssh://git@push\.\(yoctoproject.org\|openembedded.org\)/#git://git.\1/#" \
+        # Use https instead of ssh
+        -e "s#ssh://git@push\.\(yoctoproject.org\|openembedded.org\)/#https://git.\1/#" \
         /home/pokybuild/yocto-autobuilder-helper/config.json && \
     sed -i \
         # imp was removed in python 3.12, switch to importlib \

-- 
2.47.3

