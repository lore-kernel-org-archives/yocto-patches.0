Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.8927.1713433766054891939
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Apr 2024 02:49:26 -0700
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-347e635b1fcso429936f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Apr 2024 02:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1713433764; x=1714038564; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lkamq8WI9gLLtlk41Fo8QUSONUmHDTV3JDlYy3BQ4ro=;
        b=CfijjDZ2p52b4MN4DsSAdaPoDzVXEhVJ4KKPq3UqUNTcIZ1UxkSU0qQrkofBer1dCu
         UjcnFIhQWlOlZyxnPJUP2ILL/IcjA/W8ZiLMs7XCJc0vzFqjMCWJT5ff3RxTsKWa9piI
         YN0K68hwomG/hUmS+loRLw4oSUPymp/MurRUCGrkOCTGtlmKrn7gqhQMJZFgE0sGRLe7
         dzgGq+kMSJQ+R0qYygzibKR7NbR3dD3r53XVCreAM+25y7JeODxnq+aoanoigLd3afSG
         q7UytwUcNNg6DC61wVEsz6qesOB9vm6IKD8UltR/BW9GfzN0wbZG4F4mlp0hH5wGkaBn
         vhBw==
Return-Path: <ninette@thehoodiefirm.com>
From: "Ninette Adhikari" <ninette@thehoodiefirm.com>
Subject: [PATCH 0/2] [yocto-autobuilder-helper] M10: Metrics view: CVEs per branch section and M11: Unify metrics views
Date: Thu, 18 Apr 2024 11:49:10 +0200
Message-ID: <20240418094921.86489-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie, hulkoba <jacoba@neighbourhood.ie>
List-ID: <yocto-patches.lists.yoctoproject.org>

From: hulkoba <jacoba@neighbourhood.ie>

This work is done according to "Milestone 10: Metrics view: CVEs per branch section and 
Milestone 11: Unify metrics views" as stated in the Scope of Work with
Sovereign Tech Fund (STF) (https://www.sovereigntechfund.de/).

This patch affects the repository: https://git.yoctoproject.org/yocto-autobuilder-helper

This change does:
- Don't create chartdata-lastyear.json files because they are not needed anymore
- Change format for generated cve-per-branch-report so it can be interpreted by the metrics view:

```
...
CVE counts by recipes:

linux-yocto: 134
  https://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-1999-0524
  https://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-1999-0656
...
}
```

Ninette Adhikari (1):
  cve-report: Reformat txt recipe list per branch

hulkoba (1):
  generate-chartdata: do not create lastyear json files

 scripts/cve-generate-chartdata          | 16 +-----------
 scripts/cve-report.py                   | 34 +++++++++++++------------
 scripts/patchmetrics-generate-chartdata |  8 +-----
 scripts/run-cvecheck                    |  1 -
 4 files changed, 20 insertions(+), 39 deletions(-)

-- 
2.34.1

