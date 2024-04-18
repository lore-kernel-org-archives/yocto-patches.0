Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.8930.1713433770275858561
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Apr 2024 02:49:30 -0700
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34782453ffdso597441f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Apr 2024 02:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1713433769; x=1714038569; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QvTOWeGJh+IUONwsTzjDQsg/Jg+VFyJHVSEUgv/2As4=;
        b=JI24ZobmWdbAShC/a595owjpDZjLVhMfXJwcvleU1IdbyV6KNCWivjKz+B+eCQl5Fp
         VYr7UQ+4i2ejC31UTXdlQy/DfWm1EZFvzTKVcubSRUl8HSK8CaoZTw+dchEUVrYtmHe4
         XX98kBFVuwqDJt+GWgxPI5JcOfVs2XvPADGQuIfQL5dHIoAKxbSmRwMhfUCIApyhiAnP
         fK2oNwwt59gxUvAf9/dCQpn/gPdnhCrUCbTCfyBf+MI9n8Lj3BHK4/fJPKaiHQDRvzCy
         9V4W6aVQzxJnfGSoskV8GqNi23S2himOEdlkDuW25mN0NeBVQ4vN/jQ4RUYsYhtadVKo
         Mi/Q==
Return-Path: <ninette@thehoodiefirm.com>
From: "Ninette Adhikari" <ninette@thehoodiefirm.com>
Subject: [PATCH 0/4] [yocto-metrics] M10: Metrics view: CVEs per branch section and M11: Unify metrics views
Date: Thu, 18 Apr 2024 11:49:13 +0200
Message-ID: <20240418094921.86489-4-ninette@thehoodiefirm.com>
In-Reply-To: <20240418094921.86489-1-ninette@thehoodiefirm.com>
References: <20240418094921.86489-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie, hulkoba <jacoba@neighbourhood.ie>
List-ID: <yocto-patches.lists.yoctoproject.org>

From: hulkoba <jacoba@neighbourhood.ie>

This work is done according to "Milestone 10: Metrics view: CVEs per branch section and 
Milestone 11: Unify metrics views" as stated in the Scope of Work with
Sovereign Tech Fund (STF) (https://www.sovereigntechfund.de/).

This patch affects the repository: https://git.yoctoproject.org/yocto-metrics/

Yocto currently maintains two views to display metrics: a multi-year and a single-year view.
Unifying them facilitates a more seamless user experience, and improves the maintenance of the website.
Yocto gathers the amount of CVEs per branch at the top of their metrics view.
However, the presentation of this information is not descriptive enough and it’s spread across several files.
This change adds collapsible, nested lists to show all cve information.

Technical details:
- Remove index-full.hmtl and only load the complete set of data
- Use pico.css to improve UX
- Use echarts and add a separate controls section (zoom) for this purpose and remove interactivity from the old charts themselves
- Load releases.csv only once
- Show current CVE count per release, parse txt files with CVE lists to group them by project and display their total CVE count.
  Inline this data on the page in details elements so there’s no need to navigate away.
- Handle dark mode

Note that there will be another patch for the autobuilder-helper project where we update the data that is used.

Please also note that there will be another milestone for improving the charts.
It will improve performance, add descriptions and improve developer documentation.

Screenshots for Light theme
https://github.com/neighbourhoodie/yocto-autobuilder-helper/assets/4191287/f6d3013e-d192-4400-945c-9a2dfc8acb26
https://github.com/neighbourhoodie/yocto-autobuilder-helper/assets/4191287/4f90648f-f8df-4e25-8d6e-1fc16fa37223
https://github.com/neighbourhoodie/yocto-autobuilder-helper/assets/4191287/260d06a5-3048-482c-b005-ab96882d24c7

Screenshots for Dark theme
https://github.com/neighbourhoodie/yocto-autobuilder-helper/assets/4191287/a098e337-11c3-4188-811b-9652b8e40c13
https://github.com/neighbourhoodie/yocto-autobuilder-helper/assets/4191287/fd8797da-509e-445f-9d7b-5801b595fff9
https://github.com/neighbourhoodie/yocto-autobuilder-helper/assets/4191287/512334fd-5220-44dc-9dd2-550593fe8437

hulkoba (4):
  patch-status: merge index- and index-full.html
  patch-status/index.html: use pico.css
  patch-status/index.html: use echarts to display all charts
  index.html: show summary in a collapsible list

 patch-status/index-full.html                  | 266 ------
 patch-status/index.html                       | 754 ++++++++++++------
 patch-status/resources/echarts.min.js         |   1 +
 .../resources/pico.fluid.classless.min.css    |   4 +
 4 files changed, 495 insertions(+), 530 deletions(-)
 delete mode 100644 patch-status/index-full.html
 create mode 100644 patch-status/resources/echarts.min.js
 create mode 100644 patch-status/resources/pico.fluid.classless.min.css

-- 
2.34.1

