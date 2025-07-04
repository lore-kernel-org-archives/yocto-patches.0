Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8D1C83F0B
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 17:12:08 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web11.1108.1751649119210356897
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 10:11:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HIasjoRG;
 spf=pass (domain: konsulko.com, ip: 209.85.160.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a823b532a4so11732961cf.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 10:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751649118; x=1752253918; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iC7XnOw2guosJsuzFYSn+LJ7WJLDLWWIipF/afE1ayI=;
        b=HIasjoRGbXdi35LxzrhYUrEZ/TTqR4D/0BRTRonQ3IUUMumeBRnn/w044LGh/Vo00t
         Bqafij0k91nm9SabbpO/8hakk/64D7S546zVQikzQxCdDCd5j1r9Szb55R5UNU8Ls1Nj
         OX/Y00e0t7V+NueLvSkpUvsBCsYLxRpYU+FdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649118; x=1752253918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iC7XnOw2guosJsuzFYSn+LJ7WJLDLWWIipF/afE1ayI=;
        b=hPf/n4SfM4uBMvAkjiZjKAu1UDY746gTuYN06JaZ8wxwMQDy8cnTim46sMexXXYCPr
         2MvpOzbNz4o9nsQuTgdp3h2ZudLlYQLg2EQ7LQg8fnYtaV2XXfjPgjKoZYocBNvvD2hR
         hLoS2F0cWAwlMyV/9La8co8iZSEK4b+DDBQifo3xIVOaMBxqTD2ujG7l5VpA2A3J3age
         53RFmstI5+DkB+llDGOI6BHPGlDiKiCjJdZYyT79i3h0ChyktZdP2iu9+ETr8puWtVY7
         MfMBrLwXKobuUyfqk3C3etDxmgzobw3jIjxU1nZivquuSA+lMvrQ46ALTSgsCNt483Pj
         M7VQ==
X-Gm-Message-State: AOJu0Ywwxjkst8lV2HAICZfDwlx3bb/Jg4D8z41Gl99v7WYLw1ZrCQyX
	w2ugSiI+JtKonySWvpnHxJO26tEFfkXS+TPO6l489fPbh+XA5Mm7LiPksikwziO5+Jd5OvvL+aY
	bduGQ
X-Gm-Gg: ASbGncvlzrVRy5loXRauUVMABRSdP4tt3I6yo7rVE9AUN37YTAcIL9w3fQTucjLamoJ
	zlzQ7q4Ud7rM6Hv5RBVGzgOTNBM/fisvd7st0bHEXxMjAeKavGutm9m7SHEYT+6Yn9BEc13khNs
	lI7CS/JzhnHTjEQ/ER907v5rYq2WIh82TQhmtyaCkdukXEYKxqRr9d8u6vgoBGy4jicVXDxN8wa
	WBVrIsgAq8E/31hH7ujx8MwcV09vUALaDigklJOlQ3bckeYYjBhU6x3AH/Fl14nM/xVBzEP3R4d
	uWP4zsqqULWPz61mGXhLc99NysosTy08znUgeGq7tYpYqg/L4vspEtmF5q2rh07/QmzvjKbDf4d
	azMsNP3fbm4nD5Jv8jIDVzJWtdnt15kbJajgWew==
X-Google-Smtp-Source: AGHT+IHCohdiVzdfYNdFeXzFJsWGoCflX+C75o4V5OyvWkeuBHSMETZSCI4SNvqjKvAj9n05FkhGKA==
X-Received: by 2002:a05:622a:14f:b0:4a5:9b9c:2d9f with SMTP id d75a77b69052e-4a996441f12mr45346781cf.2.1751649117848;
        Fri, 04 Jul 2025 10:11:57 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949f99dcsm17249611cf.19.2025.07.04.10.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:11:57 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>,
	Scott Murray <scott.murray@konsulko.com>
Subject: [meta-security][PATCH 09/12] chkrootkit: use Debian mirror
Date: Fri,  4 Jul 2025 13:11:13 -0400
Message-ID: <c16cc136d82c80618ed10b4354326b792cf88574.1751647559.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751647559.git.scott.murray@konsulko.com>
References: <cover.1751647559.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 17:12:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1761

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Use the Debian mirror as the Ubuntu one is failing frequently.

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-scanners/rootkits/chkrootkit_0.58b.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-scanners/rootkits/chkrootkit_0.58b.bb b/recipes-scanners/rootkits/chkrootkit_0.58b.bb
index a6c4090..0fcc55d 100644
--- a/recipes-scanners/rootkits/chkrootkit_0.58b.bb
+++ b/recipes-scanners/rootkits/chkrootkit_0.58b.bb
@@ -5,7 +5,7 @@ SECTION = "security"
 LICENSE = "BSD-2-Clause"
 LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=6db4d77fb8f0cc84d175e7a1211e4c13"
 
-SRC_URI = "http://archive.ubuntu.com/ubuntu/pool/universe/c/${BPN}/${BPN}_${PV}.orig.tar.gz \
+SRC_URI = "${DEBIAN_MIRROR}/main/c/${BPN}/${BPN}_${PV}.orig.tar.gz \
            file://musl_fix.patch"
 
 SRC_URI[sha256sum] = "75ed2ace81f0fa3e9c3fb64dab0e8857ed59247ea755f5898416feb2c66807b9"
-- 
2.50.0


