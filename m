Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.8929.1713433769025002364
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Apr 2024 02:49:29 -0700
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-418e4cd1ffaso3292425e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Apr 2024 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1713433767; x=1714038567; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YcvSooJZq6tHLnMVKHZbAp+oKhNAoHNlM+ceSBvq3T0=;
        b=1jTinFQ60OrnL/9dnb5ui0/4RpvAk01XLT9PnxXsKEiZ4Qdh8mRf97ymMaBfSsUs2e
         buJG8YqFqS3Xv21otcefHI/+8CW0gKtNuiduAnKcBRC+j9igyzoUL8Ic9+80qRCye0YF
         6dDhPRXMTbJ6vkH9hN5SA5gYB8lnQhJ9L/9wx7Kvo6nqUO3B1ttTyZRE7pQnVNDyhvhS
         fB5auRxr1yAlzoj0BIcmWZs6E3JuqVwjPHB/uzhxjUcR9xAPguvYncF5JWfV4+6M3Ies
         XTGHYP5ugo82fH8uld9Kczs/FUmc7Pgb8PF1u5hNO1dByfCe8sRGYYddshDTGRGCQsbJ
         +m5w==
Return-Path: <ninette@thehoodiefirm.com>
From: "Ninette Adhikari" <ninette@thehoodiefirm.com>
Subject: [PATCH 2/2] generate-chartdata: do not create lastyear json files
Date: Thu, 18 Apr 2024 11:49:12 +0200
Message-ID: <20240418094921.86489-3-ninette@thehoodiefirm.com>
In-Reply-To: <20240418094921.86489-1-ninette@thehoodiefirm.com>
References: <20240418094921.86489-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie, hulkoba <jacoba@neighbourhood.ie>
List-ID: <yocto-patches.lists.yoctoproject.org>

From: hulkoba <jacoba@neighbourhood.ie>

the two html files, index.html and index-full.html,
got merged so we only need the json file with the complete set of data.
---
 scripts/cve-generate-chartdata          | 16 +---------------
 scripts/patchmetrics-generate-chartdata |  8 +-------
 scripts/run-cvecheck                    |  1 -
 3 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/scripts/cve-generate-chartdata b/scripts/cve-generate-chartdata
index dbbbe82..e187f8b 100755
--- a/scripts/cve-generate-chartdata
+++ b/scripts/cve-generate-chartdata
@@ -6,7 +6,7 @@ import subprocess
 import tempfile
 from datetime import datetime, date, timedelta
 
-args = argparse.ArgumentParser(description="Generate CVE count data files")
+args = argparse.ArgumentParser(description="Generate CVE count data file")
 args.add_argument("-j", "--json", help="JSON data file to use")
 args.add_argument("-r", "--resultsdir", help="results directory to parse")
 args = args.parse_args()
@@ -18,16 +18,12 @@ except FileNotFoundError:
     # if the file does not exist, start with an empty database.
     counts = {}
 
-lastyear = {}
-
 #
 # Write CVE counts by day
 #
 def round_to_day(val):
     return int((datetime.fromtimestamp(int(val)).date() - date(1970, 1, 1)).total_seconds())
 
-a_year_ago = (datetime.now() - timedelta(days=365) - datetime(1970, 1, 1)).total_seconds()
-
 for branch in os.listdir(args.resultsdir):
     branchdir = os.path.join(args.resultsdir, branch)
     for f in os.listdir(branchdir):
@@ -51,15 +47,5 @@ for branch in os.listdir(args.resultsdir):
             print("Adding count %s for branch %s from file %s (ts %s)" % (count, branch, cvereport, rounded_ts))
             counts[rounded_ts][branch] = str(count)
 
-for c in counts:
-    if int(c) > a_year_ago:
-        lastyear[c] = counts[c]
-
 with open(args.json, "w") as f:
     json.dump(counts, f, sort_keys=True, indent="\t")
-
-with open(args.json.replace(".json", "-lastyear.json") , "w") as f:
-    json.dump(lastyear, f, sort_keys=True, indent="\t")
-
-
-
diff --git a/scripts/patchmetrics-generate-chartdata b/scripts/patchmetrics-generate-chartdata
index 2c85fb1..1b83270 100755
--- a/scripts/patchmetrics-generate-chartdata
+++ b/scripts/patchmetrics-generate-chartdata
@@ -6,7 +6,7 @@ import subprocess
 import tempfile
 from datetime import datetime, date, timedelta
 
-args = argparse.ArgumentParser(description="Generate Patch Metric Chart data files")
+args = argparse.ArgumentParser(description="Generate Patch Metric Chart data file")
 args.add_argument("-j", "--json", help="JSON data file to use")
 args.add_argument("-o", "--outputdir", help="output directory")
 args = args.parse_args()
@@ -30,10 +30,7 @@ json.dump(latest, open(args.outputdir + "/patch-status-pie.json", "w"), sort_key
 def round_to_day(val):
     return int((datetime.fromtimestamp(int(val)).date() - date(1970, 1, 1)).total_seconds())
 
-a_year_ago = (datetime.now() - timedelta(days=365) - datetime(1970, 1, 1)).total_seconds()
-
 newdata = []
-lastyeardata = []
 databydate = {}
 for i in data:
     rounded = round_to_day(i['date'])
@@ -47,8 +44,5 @@ for i in databydate:
         if todel in databydate[i]:
             del databydate[i][todel]
     newdata.append(databydate[i])
-    if int(databydate[i]['date']) > a_year_ago:
-        lastyeardata.append(databydate[i])
 
 json.dump(newdata, open(args.outputdir + "/patch-status-byday.json", "w"), sort_keys=True, indent="\t")
-json.dump(lastyeardata, open(args.outputdir + "/patch-status-byday-lastyear.json", "w"), sort_keys=True, indent="\t")
diff --git a/scripts/run-cvecheck b/scripts/run-cvecheck
index 373f57c..d22dc82 100755
--- a/scripts/run-cvecheck
+++ b/scripts/run-cvecheck
@@ -105,5 +105,4 @@ if [ "$BRANCH" = "master" ]; then
     fi
 
     cp $METRICSDIR/cve-count-byday.json $RESULTSDIR
-    cp $METRICSDIR/cve-count-byday-lastyear.json $RESULTSDIR
 fi
-- 
2.34.1

