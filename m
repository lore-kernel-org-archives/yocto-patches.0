Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.157891.1712719706887292802
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Apr 2024 20:28:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=Mzy/jCW7A1BihhCxh+
	cqYZNi3WnOk8mATJts/fuhTPk=; b=KLYQzf7zjrDpYmt9LbWkL1OMRpe2lIaBkE
	W+CrLumx+4z4wZU7T0zprB1n8Z6gA33jQoQBaV8y+T9bIA/PSvTJDnvd12+9IlUE
	dIqSwvp1Xx9rp804W0kCMz4+u2ia459tGjUEEEtC4js2XL1XL5Ou6Xco7mz5h55r
	f4H5zO9eAIAKKe4NpVv3rmpW5+NfLawe9U4tiuf4bfNW5KTGW2scOYCi+bpAP37l
	sH1pxmSUNxfGzCvYqGzG9dAdEEnhVyYGt0vdUaQo5SiHygoaIDjgi49a0DxwzTMu
	TnalqqPI9X1aLuxQaJnFC111JhATNL4JiUCjhJ+NrvMNYvq6PoJg==
From: "Yi Zhao" <yi.zhao@eng.windriver.com>
Subject: [meta-selinux][PATCH] MAINTAINERS: update to new yocto-patches mailing list
Date: Wed, 10 Apr 2024 11:28:10 +0800
Message-Id: <20240410032810.93843-1-yi.zhao@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
To: yocto-patches@lists.yoctoproject.org, joe.macdonald@siemens.com, joe_macdonald@mentor.com, joe@deserted.net
List-ID: <yocto-patches.lists.yoctoproject.org>

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa6c484..016f325 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1,13 +1,13 @@
 This file contains a list of maintainers for the meta-selinux layer.
 
 Please submit any patches against meta-selinux to the Yocto Project mailing
-list (yocto@lists.yoctoproject.org).
+list (yocto-patches@lists.yoctoproject.org).
 
-git send-email -1 --to yocto@lists.yoctoproject.org --subject-prefix=meta-selinux][PATCH
+git send-email -1 --to yocto-patches@lists.yoctoproject.org --subject-prefix=meta-selinux][PATCH
 
 These values can be set as defaults for this repository:
 
-$ git config sendemail.to yocto@lists.yoctoproject.org
+$ git config sendemail.to yocto-patches@lists.yoctoproject.org
 $ git config format.subjectPrefix meta-selinux][PATCH
 
 You may also contact the maintainers directly.
-- 
2.25.1

