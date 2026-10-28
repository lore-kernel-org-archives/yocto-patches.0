Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37021.1793168514236429486
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Oct 2026 23:21:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wBXTnQWlOFqsCQAAA--.391S3;
	Wed, 28 Oct 2026 14:20:06 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowACXKWqzk+FqpjMmAA--.21753S3;
	Wed, 28 Oct 2026 14:18:41 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [meta-selinux][PATCH 2/2] MAINTAINERS: update information
Date: Wed, 28 Oct 2026 14:21:21 +0800
Message-ID: <20261028062121.1753730-2-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028062121.1753730-1-chenqi_hycx@cetc.com.cn>
References: <20261028062121.1753730-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowACXKWqzk+FqpjMmAA--.21753S3
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYOCmrgqJISyQAAsr
X-CM-DELIVERINFO: =?B?JYDLHqc9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOF0BZZGk50lASsqm66SY1oe0O2mVM/UrUMwWE+L/92zBR4zjMGzBXAxRusLkU7ANw4+/
	ToeCgrLaSnBSam53MKugih1JYiPKx5aqylVbYb/OHt0cFOWiCweCl52B4KJX+w==
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw4rKry7XF4fZrWxWry3Awc_yoW3KFc_C3
	9rGayDWFyUCFyIkayIgF9IkrZYkrW7GFnrX3Z2q3ZxA34DAr90qrWkKFn3u345JFW7KF4Y
	ga45Xayakr4j9osvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjgY5I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVW8AbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E
	87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWU
	XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4kE6xkIj40Ew7xC0wCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
	daVFxhVjvjDU0xZFpf9x07jOsqXUUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 06:22:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5166
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

I'll be maintaining meta-selinux for all active branches.
Update this MAINTAINERS file to include this information.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42a85e2..2933168 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25,6 +25,16 @@ Please keep this list in alphabetical order.
 
 Maintainers List (try to look for most precise areas first)
 
+COMMON
+M:	Chen Qi <chenqi_hycx@cetc.com.cn>
+L:	yocto-patches@lists.yoctoproject.org
+Q:	https://patchwork.yoctoproject.org/project/yocto/
+S:	Maintained
+F:	conf
+F:	classes
+F:	dynamic-layers
+F:	recipes-*
+
 COMMON
 M:	Joe MacDonald <joe.macdonald@siemens.com>
 F:	conf
-- 
2.43.0

