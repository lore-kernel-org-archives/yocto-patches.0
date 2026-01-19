Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE92FC619B
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:28:53 +0000 (UTC)
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44330.1768854523314632464
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:28:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=E23KIm8s;
 spf=pass (domain: konsulko.com, ip: 209.85.219.66, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-88888c41a13so64957046d6.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768854522; x=1769459322; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIp53e4wLwyAMivLd+6OyCTeURFJ7r5eBjzgCvqJMt8=;
        b=E23KIm8s8xLGD4NkH0xk9ezvuJhfn5rOGkPve++l76FDvwTuWkqwWjs88LnWUhuJ5P
         pCOz/m6y4dRKZ/kJ1ajCS0o+5HjKwtJZt+C53O3fWRPD04IzzgYIotmFCyd3T70arJkS
         Nd2KSMCzUin+sOQieLmVdXdQwoxkv1WlwYNuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854522; x=1769459322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KIp53e4wLwyAMivLd+6OyCTeURFJ7r5eBjzgCvqJMt8=;
        b=Fw3/IKQJ7O5BON0CIIruN9Dfeop5Bt2gzFFfe1Dqh9PQM1xRuY/KNyGLR6jbOkJorF
         BZ9fBWOQ0xBjy2fkYFPulR8HHilGTqPFQ4cERVdEShWMb5w4GRi6HyWY/aJDopfCVHvA
         O9GPtT6gXoEp6RBoT5Vpjo45fTGo0f+eZWXIDlEaCw0WbdAVwp7Q8A9SxunG5VX21GSv
         AgDF3qJZpc63gzVLNs1nqPjMo5iQ0gYkr9JdmlvRqSWmfrUjbQT5XqYP4Xc2/RfWXxjF
         D7R6Qvvwlm/xrOm+ByJlILz1Jv8+7XMERkpFwSXZMAnySfYD4ijtvFsfzugYkFLIvh64
         5csA==
X-Gm-Message-State: AOJu0Yxo/TvGEvXxcNQ1JsTYa4qcg2tar2vz0+TYF5UbAWxaSwJ4eOvw
	T4hjxPOuhPoqJ/oAUjw5BmOnWV3pBUsS3lcpcKE0DmWobFBTJ+gaN3Ffg0gjayYDr3saWK6Qy/n
	rrLesBnc=
X-Gm-Gg: AY/fxX7dvIz5H61dF9xz5p0B7NRfpyBFf/9++ZjGDuFayT/+dKzdr6kGbc7bd+pAOoD
	KqoyO/4HfktiUvGXDm1vNjtsOy9PqnFL5SBvqcF/rEVS5MkfTIFehvNdVSeGGaT7Vxz9UKFH6/2
	QdycYWqvLpzVquYIGV6l1pmp9Re976wwF4DDNq1lbQHDzP4d9aIFcuRLx5QwZ0G3Jgb9D62aa4l
	JiW9fbPu0jaEiuX9lJeqplqmJ7lgi7cjHXsmWF9SoMvlDqIziPYguHtIodsyN2BU6Tqma6xiGqZ
	YF19Uq3KaSOqAe9Squ01U8YScH7cOIFosTCF0oJMCAICiJMkP5tiEbXppsr5ufF9UxgI/TV2dYb
	u7acxhl533SQLyL4g3vAvy6LjE6GogOAcXRKOkF6KPFSQgslWVT9s1XPCsBUqfC34dcI2GiZ16L
	cUv5aDsvMyC+Ckj0SYpYSgFW+vr+cUtJE+MNxu6mkS6V5KGZzKzP5rMf3EIaLeAUDelqhSiFLFj
	ZMfArIzI3Q1GQtOZPHsyj9urj3ObVcDsCqpUw7z2po3nDyYTPhf
X-Received: by 2002:ac8:5810:0:b0:501:463a:20a1 with SMTP id d75a77b69052e-502a17d3611mr163269381cf.81.1768854521996;
        Mon, 19 Jan 2026 12:28:41 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1f21c9asm82661411cf.34.2026.01.19.12.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:28:41 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-lts-security][PATCH 3/3] dm-verity-img.bbclass: filter units from value part
Date: Mon, 19 Jan 2026 15:28:23 -0500
Message-ID: <9e6d962250aab6e5319215f15b0201ef233c46cd.1768854292.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768854292.git.scott.murray@konsulko.com>
References: <cover.1768854292.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:28:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3017

From: Stephan Wurm <stephan.wurm@a-eberle.de>

This is necessary for cryptsetup starting from v2.8.0 which introduced
"[units]" in its output breaking the parsing of veritysetup output.

VERITY header information for image-poky-20250701085433.squashfs-zst.verity.
UUID:                   5dc16c55-79b8-4988-9d79-900f8e143f98
Hash type:              1
Data blocks:            40091
Data block size:        4096 [bytes]
Hash blocks:            318
Hash block size:        4096 [bytes]
Hash algorithm:         sha256
Salt:                   f670bf67a32f4f5a22e052d7bf84830f8d35ea24e2d52f585f6275207899153b
Root hash:              a7eab55b7933e347650671611e4b2a10571f2a28a1fb0fc8eae409f7a0d86693

This extends the value filter to remove the "[units]" from the .env file,
while retaining compatibility to older cryptsetup releases.

Signed-off-by: Stephan Wurm <stephan.wurm@a-eberle.de>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/dm-verity-img.bbclass | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass
index 47f698c..48557e9 100644
--- a/classes/dm-verity-img.bbclass
+++ b/classes/dm-verity-img.bbclass
@@ -71,12 +71,12 @@ process_verity() {
     # two parts into separate variables and process them separately. For the
     # key part: convert the names to upper case and replace spaces with
     # underscores to create correct shell variable names. For the value part:
-    # just trim all white-spaces.
+    # just trim all white-spaces and remove units.
     IFS=":"
     while read KEY VAL; do
         printf '%s=%s\n' \
             "$(echo "$KEY" | tr '[:lower:]' '[:upper:]' | sed 's/ /_/g')" \
-            "$(echo "$VAL" | tr -d ' \t')" >> $ENV
+            "$(echo "$VAL" | tr -d ' \t' | sed 's/\[.*\]//')" >> $ENV
     done
 
     # Add partition size
-- 
2.51.0


