Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
 by mx.groups.io with SMTP id smtpd.web10.14628.1713364538206052943
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Apr 2024 07:35:38 -0700
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1e2b137d666so46192075ad.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Apr 2024 07:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1713364537; x=1713969337; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GoJU6Sj3z16el2qHH88PZiHTBrxClJBcidCoze16dMk=;
        b=M2pN1itiXfSgInTLonRrWUX9qqRfu6zn4R5NCJOc3lsoneN5/ccpls7t9Bxa12056X
         YhJrwh+CVSaT5aYZJvCtkrjwZi5HCboMHqukbqAFCz6c8SCNgp+c+lN6hSpQBcZJFSvl
         UKUvHvFe2vWxj7uutT8j8hExivwCIE2n+Ogdc=
Return-Path: <tim.orling@konsulko.com>
From: "Tim Orling" <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/2] build(deps): bump sqlparse from 0.4.4 to 0.5.0
Date: Wed, 17 Apr 2024 07:35:18 -0700
Message-ID: <20240417143529.106594-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
Cc: "dependabot [bot]" <support@github.com>, Tim Orling <tim.orling@konsulko.com>
List-ID: <yocto-patches.lists.yoctoproject.org>

From: "dependabot[bot]" <49699333+dependabot[bot]@users.noreply.github.com>

Bumps [sqlparse](https://github.com/andialbrecht/sqlparse) from 0.4.4 to 0.5.0.
- [Changelog](https://github.com/andialbrecht/sqlparse/blob/master/CHANGELOG)
- [Commits](https://github.com/andialbrecht/sqlparse/compare/0.4.4...0.5.0)

---
updated-dependencies:
- dependency-name: sqlparse
  dependency-type: direct:production
...

Signed-off-by: dependabot[bot] <support@github.com>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/requirements.txt b/requirements.txt
index 6090ea8..9a5d0de 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -32,7 +32,7 @@ pytz==2024.1
 six==1.16.0
 smmap==5.0.1
 soupsieve==2.5
-sqlparse==0.4.4
+sqlparse==0.5.0
 typing_extensions==4.11.0
 tzdata==2024.1
 vine==5.1.0
-- 
2.43.2

