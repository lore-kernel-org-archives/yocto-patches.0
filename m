Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02428C282D9
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:03:41 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web10.10110.1741169016253913261
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 02:03:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=OX1rwgYM;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D49A4427D;
	Wed,  5 Mar 2025 10:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741169014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+szPKIpvm68zvxRutbhRLaQBgoVfmn8jSqb2t1xIFq4=;
	b=OX1rwgYMCIu46Q9Gzknh/x8cFHvr28kYqOlripBKhDVoQDL+X3lhq3ikxu+AqVc2ytDqT0
	v62u9HA2ZPGjxPp9+EsI5765eucQIP8EOxyPtY9VnJ4UfQ4CydgeT5B6EDmAEWe+wU5Za0
	EoXCgOwHm++KQ6K8LXvHkTRbJ3n4lXVWL6r7Q0+HeIU0l+zQ6dzJiXewRV1dOmvtfusBmS
	9C8khin+99uTwr7ArsCLTTJqaMFeXIhcmmGheJT36LQ2ctcAI9QBFiu84m5h3aDaSlG1+a
	ynt+UY1YydrADoVIGNB/Lw76iMAxqZx2iXPpByCEEEsHNw2XC6ZutOh5IEB0TA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 05 Mar 2025 11:03:05 +0100
Subject: [yocto-autobuilder-helper PATCH 1/2]
 scripts/yocto-supported-distros: run bitbake-getvar with --quiet
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-yocto-supported-distros-fixes-v1-1-308df26dd6d9@bootlin.com>
References: <20250305-yocto-supported-distros-fixes-v1-0-308df26dd6d9@bootlin.com>
In-Reply-To: <20250305-yocto-supported-distros-fixes-v1-0-308df26dd6d9@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=YjvifuHn+4yYVjfQdoDxerlNhQCfDqPk+XiaZq++RCw=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnyCF1NexxPr56CCGoVtfTa3VdFWqYRv0vub2wS
 yCkFqeEBheJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ8ghdQAKCRDRgEFAKaOo
 NiclD/0Qpy2MJmOzF8pBVWvS/ODErz2MZZ3ncvL2KGjq1Fj+kNx3xZiJ3rrJ3rnKsw6tEC0qcHB
 RRlLvM0hu2iDUSZp1yuw35STwHGdq3eoGQ1fLelUl+zh6qMhMYZsRVIV+flNu05KLRsWJYV/qmZ
 VfbTC/6wCxewIkHI4ycUZZt2vIrj4dCmuvfMdEA4rWrYC1I1+U5cUQacA5BJM5OAD+fVlI80F16
 Zexn0KKbWaH3CeBKAAUMaXZeJkuEuzglIkw3ejg9opV2yL9TmJ4NirafnKsCBp/9H/T5fOSia0x
 emEqEDULst5pS5lCz6vfd+H0r8dZQYw201hjXbnFUrrVibXKS8YKmrhCjt8v36pb+7wNl95/Rca
 DU4AShI4YHgH6yUZs3iR6XDUgiCLuTVUs/657tdih32WkKa2sJHRTCkZSemuMS3bJYyD/ImKlCl
 MDAIYRM/DlGKKTZpyYL5hE0xkBcMPsoP3iay2YuBLnGjNjso9oK7djrWc9+QFXV1VHLmekYL/Ct
 MTWzDnbssfUBxg0RTJeU1+lmxgG2CxLKhxeAHY1VBozU72CK2UtaRatx3MQJO/AP8/+mXxKuNWh
 FMy8IdGpdCE3zxLOKn6XnRn6W7gHnQMSDXHk7IUEsGIP+LjtTcxc3ODdbFw6WzHpEkO/SS3YlH0
 NnaAVbssyJn+dRA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdeghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieeguefhfeegheffgfeuieetheeileefheejkeetgfekueehueeluddvlefghfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhst
 hhsrdihohgtthhophhrohhjvggtthdrohhrgh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 10:03:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1142

On older releases the bitbake server output is confusing the script.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/yocto-supported-distros | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index e0550ebcc6d437f7d774a982742b89af1ccfab88..533e3d48bddee9c685d4e94add14c66d2406621c 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -129,7 +129,7 @@ def _get_poky_distros() -> Set[str]:
     poky_distros = set()
 
     tested_distros = subprocess.check_output(
-        ["bitbake-getvar", "--value", "SANITY_TESTED_DISTROS"],
+        ["bitbake-getvar", "--quiet", "--value", "SANITY_TESTED_DISTROS"],
         encoding="utf-8")
     tested_distros = tested_distros.replace("\\n", "")
 
@@ -151,7 +151,7 @@ def _get_poky_distros() -> Set[str]:
 
 def _get_metadata_branch() -> str:
     branch = subprocess.check_output(
-        ["bitbake-getvar", "--value", "METADATA_BRANCH"],
+        ["bitbake-getvar", "--quiet", "--value", "METADATA_BRANCH"],
         encoding="utf-8")
     return branch.strip()
 

-- 
2.47.0


