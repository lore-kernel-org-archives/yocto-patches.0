Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37181.1793168514143234733
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Oct 2026 23:21:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wBXFBwRlOFqrCQAAA--.399S3;
	Wed, 28 Oct 2026 14:20:02 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowACXKWqzk+FqpjMmAA--.21753S2;
	Wed, 28 Oct 2026 14:18:33 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [meta-selinux][PATCH 1/2] conf/layer.conf: update to blacksail
Date: Wed, 28 Oct 2026 14:21:20 +0800
Message-ID: <20261028062121.1753730-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowACXKWqzk+FqpjMmAA--.21753S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYOCmrgqk4TFwAAsp
X-CM-DELIVERINFO: =?B?Zt4Coqc9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOLy7F2L/bYVz82xzNKeppBhvdm+THksGoe7Fu77FeF9vRa6gZdQ+g2GXU+SBKIqXfNtv
	JU4EwuBSpDCKo04FefYB/mW8H5+OnEyAhM5YR8gplWZmHL2r7i3Tz5VyxO1XCw==
X-Coremail-Antispam: 1Uk129KBj9xXoWrGF18Ar1rKrW7XFW5Aw4fZwc_yoWxXFX_Ar
	4xCrn7Zw48AFy7u3Waywn5Zr45G3W8uF4xXFyktrsFqwnFgw1aqayUG3yUJ3W3Jw1UZFy3
	XFy5Xasagr4jgosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjgY5I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVW8AbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E
	87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4kE6xkIj40Ew7xC0wCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r1Y6r17MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZF
	pf9x07jYVbkUUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 06:22:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5165
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

Update from wrynose to blacksail to match latest oe-core.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 245b4ef..3069dc6 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -17,7 +17,7 @@ BBFILE_PRIORITY_selinux = "5"
 # cause compatibility issues with other layers
 LAYERVERSION_selinux = "1"
 
-LAYERSERIES_COMPAT_selinux = "wrynose"
+LAYERSERIES_COMPAT_selinux = "blacksail"
 
 LAYERDEPENDS_selinux = " \
     core \
-- 
2.43.0

