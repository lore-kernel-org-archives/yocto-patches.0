Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.8928.1713433767288371968
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Apr 2024 02:49:27 -0700
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-347c197a464so438725f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Apr 2024 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1713433765; x=1714038565; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A9XPcPdMv9vYA2pd6IdaNnYbYRBu8CdzbXZDdxNkabE=;
        b=TzwgcwhP6+6wZBL9Q9UlDvMnL6ufNV5qY99EUSeB0A8vDOn8Pa7mlwAPMq4F7pon2o
         qHOg3/Qrd8ELr+OMI6JAhzl6aMp142n4oX4f3+viPzeKlOyIZdHXVCpZeiaf0q/DQLQm
         YUGvriG8y7olkjWkVMmRenE2TQSWxh0T6b032suqWcNZQAnSZuDs4FxWCFpBanCZ76nZ
         kC1AFWsOZ7Y7a11Gd+JXTGFHS0NPQNObKwPA1PkdoIX0lju6YkwxU4y8ilafhkvYErar
         8CbhZkpibb+ymN1QLmKUWIHun3lQP5uOVlKG0YBsAyfVcIisQGm9dzmEyfhIaOFn72og
         LRdQ==
Return-Path: <ninette@thehoodiefirm.com>
From: "Ninette Adhikari" <ninette@thehoodiefirm.com>
Subject: [PATCH 1/2] cve-report: Reformat txt recipe list per branch
Date: Thu, 18 Apr 2024 11:49:11 +0200
Message-ID: <20240418094921.86489-2-ninette@thehoodiefirm.com>
In-Reply-To: <20240418094921.86489-1-ninette@thehoodiefirm.com>
References: <20240418094921.86489-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie, Ninette Adhikari <13760198+ninetteadhikari@users.noreply.github.com>
List-ID: <yocto-patches.lists.yoctoproject.org>

From: Ninette Adhikari <13760198+ninetteadhikari@users.noreply.github.com>

Yocto gathers the amount of CVEs per branch at the top of their metrics view.
However, the presentation of this information is not descriptive enough and it’s spread across several files.
This change adds collapsible, nested lists to show all cve information.

Show current CVE count per release,
parse txt files with CVE lists to group them by project and display their total CVE count.
Inline this data on the matrics-page in details elements so there’s no need to navigate away.

The current output includes the count of cve's and the cve-urls. No data is lost here, it looks like:

CVE counts by recipes:

linux-yocto: 134
  https://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-1999-0524
  https://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-1999-0656
  ...

bluez5: 2
  https://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2022-3563
  https://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2022-3637
...
---
 scripts/cve-report.py | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/scripts/cve-report.py b/scripts/cve-report.py
index 203ea6d..38f3069 100755
--- a/scripts/cve-report.py
+++ b/scripts/cve-report.py
@@ -12,7 +12,6 @@ with open(jsonfile) as f:
     cvedata = json.load(f)
 
 cves = dict()
-recipe_counts = {}
 
 for recipe in cvedata['package']:
     if recipe['name'] in ignored_recipes:
@@ -24,21 +23,24 @@ for recipe in cvedata['package']:
             if i["id"] in cves:
                 cves[i["id"]] += ":" + recipe['name']
             else:
-                 cves[i["id"]] = recipe['name']
+                cves[i["id"]] = recipe['name']
 
-print("Found %d unpatched CVEs" % len(cves))
-for cve in sorted(cves.keys()):
-    print("%s: %s https://web.nvd.nist.gov/view/vuln/detail?vulnId=%s *" % (cve, cves[cve], cve))
+recipe_counts = {}
 
-for cve in cves:
-    recipename = cves[cve]
-    if recipename in recipe_counts:
-        recipe_counts[recipename] += 1
+for cve, name in cves.items():
+    if name not in recipe_counts:
+        recipe_counts[name] = {'count': 1, 'cves': [f"https://web.nvd.nist.gov/view/vuln/detail?vulnId={cve}"]}
     else:
-        recipe_counts[recipename] = 1
-
-
-print("\n")
-print("Summary of CVE counts by recipes:\n")
-for recipe, count in sorted(recipe_counts.items(), key=lambda x: x[1], reverse=True):
-    print("  %s: %s" % (recipe, count))
+        recipe_counts[name]['count'] += 1
+        recipe_counts[name]['cves'].append(f"https://web.nvd.nist.gov/view/vuln/detail?vulnId={cve}")
+
+formatted_data = {}
+for name, info in sorted(recipe_counts.items(), key=lambda x:x[1]['count'], reverse= True):
+    formatted_data[f"{name}: {info['count']}"] = info['cves']
+
+print("CVE counts by recipes:")
+for name, cves in formatted_data.items():
+    print("")
+    print(name)
+    for cve in cves:
+        print(f"  {cve}")
-- 
2.34.1

