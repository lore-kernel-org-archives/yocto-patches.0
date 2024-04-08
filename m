Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.99467.1712553558423223045
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 07 Apr 2024 22:19:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=5q9bAGOqFNMMcokYnu
	vjq7eCUEzz74r84UrhEt2YpcM=; b=gTD4VsysqDo60F6COUzSyCS+WBfl4ZawtR
	r0mE91RQ5JRxtHemBOB87A/+x+e8fDt5KhhfyOAWPG3XJ4MbV0SkIFmYrH3KSYse
	hwY1Xu4b0v8T7GHM2uIN6GSo6W6/OFwwHS0ECtNxvtl2v78YMdmnlsHCXWk/n6RU
	uXeI3SX8/Kdia9/M9lg9BURttgDdJbqbOrNOknN3Nkumdbo80xMujgRJMdYBRdzq
	LCqthgIeKyJlWhS57sUbHvWdNK/XEtvB5//G/fK14ZGxpdqwnGQWELQ+DLDQ/L7E
	79u2S/KN+kR3r7oJob+RCo90YMcs0g8NaJg23H0WwWGjTAfDiglA==
From: "Yi Zhao" <yi.zhao@eng.windriver.com>
Subject: [meta-selinux][PATCH] refpolicy: update to latest git rev
Date: Mon,  8 Apr 2024 13:19:02 +0800
Message-Id: <20240408051902.189739-1-yi.zhao@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
To: yocto-patches@lists.yoctoproject.org, joe.macdonald@siemens.com, joe_macdonald@mentor.com, joe@deserted.net
List-ID: <yocto-patches.lists.yoctoproject.org>

* 0aff1990e quote: read localization
* ab13c0421 getty: grant checkpoint_restore
* 3643773ae Update SOS report to work on RHEL9
* 523b279bd Setup domain for dbus selinux interface

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-security/refpolicy/refpolicy_git.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index e13fc96..322c277 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -2,7 +2,7 @@ PV = "2.20240226+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy ?= "fa84ee8fc04af56cced5ab8ed7abfb1abbd246dc"
+SRCREV_refpolicy ?= "6507eebc238b4495b1e0d3baa2bc0bb737f9819a"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.25.1

