Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9321.1795883253020629478
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:27:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=m+mDmw1g;
 spf=pass (domain: konsulko.com, ip: 209.85.221.41, mailfrom: scott.murray@konsulko.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso5159873f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795883251; x=1796488051; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tIRv0M/1H60RyWvEvndiD0zWuu+7We0vutfL9W644A0=;
        b=m+mDmw1g26tQAXPeKGZVk3t3+1Q9vSu5UWUhsd4M7Pk1VqA2NqSto6f6fAIbBLpqkp
         nuMqyc+EPkziAI99SQgKlcsYUfV0bVNMEgrnJyD53mwdUIBg0Mnik2H5XSx0NBcPf4CJ
         N4WA8tA2l2D77nvFzeefcbmNIrZJp5E2nv1xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795883251; x=1796488051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tIRv0M/1H60RyWvEvndiD0zWuu+7We0vutfL9W644A0=;
        b=k2elLyEksMfadZlBxAGl3ng0q/nnEF4deI2DYCaa8ZDHYg6H6i+7swC53jb0Xawx2R
         ydKyrtf0uotgHYX56BBk9bXRJaZIZi/B7oLnLoEGx9zchOS2qc/nntt6yNEdvFD6tcpD
         kZTNrQ/jxMszBdWKS4wwPnRSCP+QX+avrEOUBs5RBSPBXGYYPHuYlxHIemn83UEyHTJ1
         FmWslcvmpQMM4SQ/BdbT4l5GX0XN9dSqwa1/1p3H2QuSM7GnlXEELRV8GavqdZrnpgQc
         Am5UNqJMW1GtlVUML9prBxQ5yj0vmGjlxDYwoYBXCE0G/h6BRd/AyOWAaGuezVVfG0y2
         lzYg==
X-Gm-Message-State: APuU4Z8hvWBeLJNP6eAmMn0mCsL5Ax9qzXkCY8SNn5WZ+FGyfFU5MbSl
	0T/STnL2ycFVEGQ8MeuLY+fhyCvQFUWqE6Ya+mHaMHzJv+QYW/RpqWYI2qdVkvu/DGdRDh+c8Vn
	aG2bDhBs=
X-Gm-Gg: AZFdTZfsukvCFp0RhDwvDJXnmyUXjz1UJwqqNZSru9zk5TEHQu9/MahLGPnPFFgPdBm
	sAJVkIdsRPiNz2U50wmwSNYVTpyRgmB7a3odui9e6tUgf8cWOdG5Z+5aHgzAqPX48ODRoqBpE2e
	hTfn5qK5p3GsdYuTKqdg6psHpTDf+rdYD67NfNwNvQcxcNZO/r5a086OKGlccc8kXOOdvyZ4bp4
	rQgsDoZhf/XMYBrmL24mXSxAOjIoTuo2C/UFVdY2z2+oIjGovoHCvbE8T9seF1ZuvTqnkfu6Wdl
	kRJntQ2+NGTvskHQKoc3AxNHTnylzf2sglviCaXSZkugq2W12/+RX+7PSiVo7jh0QEGwFg/yLXG
	hkSYTuCzIBA8BdPiuoAZdVuA1iTw9ApqLap1Tzy2YaRiTce0SFKYDhz+8G81imt1pf15i2+sCn1
	mlEGArjBMa7irSm6CIbu+sN8gMGZsDFy8Zt2bC6nHPoxeHFSrA8ZV2l3NBuvfP/bM8NnT6sLzK9
	J0QqH0KvvtdLASSyKQ6/PGrYSfjBVCNXTUYzoOzIlKya+LSLqhGZGUF1soXi8CB4z0257RrU4fO
	y7pP4iMA3kDxjV0ugh9GhZolht1FRBnqY6psYMZkGR4w41yjlvWvkWnzs5MMw7ShwvNx9YyJ+/f
	U2M9VWgDxtV2F1PZnlPDsTqkPr2yzDQ==
X-Received: by 2002:a05:600c:1911:b0:4ba:38a9:85e3 with SMTP id 5b1f17b1804b1-4bb8880eecbmr602556295e9.12.1795883250971;
        Sat, 28 Nov 2026 08:27:30 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90655f5asm529202045e9.1.2026.11.28.08.27.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:27:30 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 06/10] python3-suricata-update: Upgrade 1.3.6 -> 1.3.8
Date: Sat, 28 Nov 2026 18:27:09 +0200
Message-ID: <f4706d6cb5bdc60e54c3d543b5736c6c8e2b760c.1795882913.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795882913.git.scott.murray@konsulko.com>
References: <cover.1795882913.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:27:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5565
Content-Type: text/plain; charset="utf-8"

Release notes:
https://github.com/OISF/suricata-update/blob/master/CHANGELOG.md#137---2025-10-31
https://github.com/OISF/suricata-update/blob/master/CHANGELOG.md#138---2026-06-30

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...uricata-update_1.3.6.bb => python3-suricata-update_1.3.8.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-ids/suricata/{python3-suricata-update_1.3.6.bb => python3-suricata-update_1.3.8.bb} (90%)

diff --git a/recipes-ids/suricata/python3-suricata-update_1.3.6.bb b/recipes-ids/suricata/python3-suricata-update_1.3.8.bb
similarity index 90%
rename from recipes-ids/suricata/python3-suricata-update_1.3.6.bb
rename to recipes-ids/suricata/python3-suricata-update_1.3.8.bb
index cdf2faa..0b2f9fe 100644
--- a/recipes-ids/suricata/python3-suricata-update_1.3.6.bb
+++ b/recipes-ids/suricata/python3-suricata-update_1.3.8.bb
@@ -5,7 +5,7 @@ LICENSE = "GPL-2.0-only"
 
 LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=c70d8d3310941dcdfcd1e02800a1f548"
 
-SRCREV = "f76a61bdee69961537585a1036c4294da28495a5"
+SRCREV = "c2687bbfc1d3bb08c569313e7bd6b178d0adafbd"
 SRC_URI = "git://github.com/OISF/suricata-update;protocol=https;branch=master"
 
 inherit python3native python3targetconfig setuptools3
-- 
2.47.3

