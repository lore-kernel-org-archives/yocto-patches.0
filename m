Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C784AC83F1D
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 09:47:56 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.9996.1752227271441748648
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Jul 2025 02:47:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Ztl+IzDG;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DF8441C7D;
	Fri, 11 Jul 2025 09:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752227269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KT4UqpRinOfFR2L48xYx/wx9pVZEm90bbakYL7ayjFw=;
	b=Ztl+IzDGuBu/vRLDCq19xh6les9tDf3e1GTAYxvez1X/plfcMdeif9y3ZZi1iLnaeUSJqN
	yYTzqwpeGv04WC5Cyn0TrZa1E1IH2fSJOSfi6UbCvZJ77/DhIVEgRGlMgUBwOfuVd1Ii6C
	5R0vx9jLri5K7XBgLxI3EDOw0V86P0poQDia60CHeq7B3NwheJRTLSFeMZJ08qfcsuf8bn
	Sjht5/aCt4aQlS/0ZsW7KphTv638s5oOO0jXrtgpvvf+LKk+afiXXiwjcfXUJXFvjzI4dZ
	5nJVHmUqGMTE9THOo1UxiHYnLkdAHK2aYVqYU0ZfRpAnQ0FlRBoSn5XzG9Malw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 11 Jul 2025 11:47:30 +0200
Subject: [PATCH] contributor-guide/submit-changes: Add real name in git
 sendmail.from
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-mathieu-sendmail_from-v1-1-c7b99352954f@bootlin.com>
X-B4-Tracking: v=1; b=H4sIALHdcGgC/x3MTQqAIBBA4avErBNU+rOrRITlWANpoRVBdPek5
 bd474GIgTBCmz0Q8KJIm08QeQbTov2MjEwySC5LXgvBnD4WwpNF9MZpWgcbNseEGmWldKNMISG
 1e0BL9//t+vf9ABfIHWdnAAAA
To: docs@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 yocto-patches@lists.yoctoproject.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752227269; l=1408;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=7sNsNsz4xkGK2lMXSveWAu/rfDunkyiNT0Gj26OYkUk=;
 b=YwkzAJKXwpmylK6TaNiKa9umGYVGmOWNJildVy1KHTpLShhOdwLQNK6/aCQr9Wj/v4zDFeLfM
 R2d1eYHi/xpB60JpdnCYf+lmvN1joa2sIvB6FNFUzH2d2L3wploOki2
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegvdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleeltdeiffehleevfeeuffekgfehvedvueeguddtkeefgefhhfffffdtgeduhfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepughotghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdpr
 hgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Jul 2025 09:47:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1801

Fix the git configuration sendmail.from example to include the user real
name in the mail "From:" field, as it would be the case when
sendmail.from is not set.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
To: yocto-patches@lists.yoctoproject.org
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 documentation/contributor-guide/submit-changes.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/documentation/contributor-guide/submit-changes.rst b/documentation/contributor-guide/submit-changes.rst
index adb78fa08d8e..336b240f93ac 100644
--- a/documentation/contributor-guide/submit-changes.rst
+++ b/documentation/contributor-guide/submit-changes.rst
@@ -541,7 +541,7 @@ author name. The following will ensure that your e-mails have an additional
 maintainers accepting your patches don't have to fix commit author information
 manually::
 
-   git config --global sendemail.from "linus.torvalds@kernel.org"
+   git config --global sendemail.from "Linus Torvalds <linus.torvalds@kernel.org>"
 
 The ``sendemail.from`` should match your ``user.email`` setting,
 which appears in the ``Signed-off-by`` line of your commits.

---
base-commit: 80084a4cabdf7f61c7e93eda8ddbd5bc7d54e041
change-id: 20250711-mathieu-sendmail_from-19b269a89d42

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


