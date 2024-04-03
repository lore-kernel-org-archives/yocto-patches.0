Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mx.groups.io with SMTP id smtpd.web10.6871.1712135593701727152
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Apr 2024 02:13:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712135593; x=1743671593;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3FNHF/cIpZCrbTTY84pxa3/Z6aZu+6PYbkkwlaO/Usc=;
  b=WPwalX8vWCpN+EkvJT9Y86jdLQOOtjiSLkWdPjn25H6J8rgCaOH6tcef
   oLQ1zKfAc0U9ZpAd6pXaJAkoC28LMSyYggDcUXG6pvnQovRGLg8qjs9wV
   XZaN9EFWBn9GsrnJjUSfPRNp6+bkiQmasaJUwt42XUfqFtNt16tO0bLvi
   wkVfm7Qow1CVX0rCOEiMepbf3RE6sZ7VHAIvqBVQHiLZBkqSkXnjzCFr+
   sfhwN4mmyDLItKVEDGLV3z0hG6zcgaucj3ZcUUQn+OQVrs+HPYfjwnRNk
   P7k+ZqZGE3UUTQGSPT1+KthCIqcibgXfbj9VDEc/W02Ci8U6Fx1ppCUCV
   Q==;
From: "Naveen Saini" <naveen.kumar.saini@intel.com>
Subject: [meta-zephyr][PATCH] README.txt: update mailing list
Date: Wed,  3 Apr 2024 17:41:48 +0800
Message-Id: <20240403094148.2184120-1-naveen.kumar.saini@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

Patches should now be sent to yocto-patches@
https://lists.yoctoproject.org/g/yocto-patches

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 README.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/README.txt b/README.txt
index ea129ba..d3694a6 100644
--- a/README.txt
+++ b/README.txt
@@ -145,12 +145,12 @@ described in "Contributing".
 Contributing
 ============
 
-Patches for meta-zephyr should be sent to the yocto@lists.yoctoproject.org
-mailing list.  See https://lists.yoctoproject.org/g/yocto for subscription
+Patches for meta-zephyr should be sent to the yocto-patches@lists.yoctoproject.org
+mailing list.  See https://lists.yoctoproject.org/g/yocto-patches for subscription
 details and the list archive.  Please add [meta-zephyr] to the subject so
 the patches are identifable.
 
 Git can be configured to send mails appropriately when using git send-email:
 
-$ git config --local sendemail.to yocto@lists.yoctoproject.org
+$ git config --local sendemail.to yocto-patches@lists.yoctoproject.org
 $ git config --local format.subjectPrefix meta-zephyr][PATCH
-- 
2.34.1

