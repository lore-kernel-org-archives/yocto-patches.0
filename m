Return-Path: <t.f.g.geelen@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54C4C2A067
	for <webhook@archiver.kernel.org>; Sun,  4 Jan 2026 00:48:59 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35343.1767487732619081622
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 03 Jan 2026 16:48:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=huKgpgiZ;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: t.f.g.geelen@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7a02592efaso1953418766b.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 03 Jan 2026 16:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767487731; x=1768092531; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIymGo77VyU0wrlUUtE/9RzfW+ZnKXDb2PwkR3ek+SA=;
        b=huKgpgiZcj47p13BsnfzUAVKpJTovogc1yFCjR0vRm8Yx0H7i8KhTcLUU2vnC7dPhz
         7n7KomFNe+vSAL84NAEJvuN72O81rq4SeSokZ/U7M6I0VsCFwT0LCdz00HUZEQWR3E1I
         flqAMSbm1p6IbGwyFILlcvM84ZGYHrGzYU7nmHYf8hb6E+vTgzvmJN+rnXmyA+IymqTt
         IupEOkHRE50JkpS2/enx33CCyExRp6/UZYWkJLf6ptRuBkUDrmhw6xmiYLN90cykkIGJ
         0CFeCl2xfkYVfuXolZKkQb4bcwbHRurmpB5F4xNSpHImJAiBCCGxCOI1Yt8QHT3HYuUA
         q/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767487731; x=1768092531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UIymGo77VyU0wrlUUtE/9RzfW+ZnKXDb2PwkR3ek+SA=;
        b=QMfKnjZIUp6wWTMSqJ8+DohG6l84WXQr+T8ii8LaCboNikTLYNN1Aserx01pTKxyhr
         RcxoQXdCNzmwTH81PFB6UMphYCA+dE/lBKrplWEPuKGxkJEdfNGPrG+cZqByE3QFu2Xx
         t5txtmd8gJ7TKN3tHrfRH/AoiK5meC9VD72jfk/iT9SJ2jDz2+1eGBeMwflZG0gwhjYp
         8dtVYw2v0ug4gbs9qVj+1Mw/u97Ey4W4NjebfYLDIw/S+c75cUWnYb1A1CLGQlebxj1E
         Xk12aDkgJmaBjVv8NrSRfVnMhPJ9++pi4fA7xfoyUWR1v7emst5JESjCYE2Go5r73beg
         r2+A==
X-Gm-Message-State: AOJu0YzGAyK2wmOmBCClX20sYWCh5acnfK9dmYVTfk5BRRXtQFH8TQdO
	aToNLQ3qaTYusjN1DU4706C//jTiOJS/GDCuQhOCC9KnuvVHWj9/r6ee/UfZ/DeC
X-Gm-Gg: AY/fxX7YvlrwRg7rBAL2JTCv9IFkuH1FSOV+/COQxvebpCMFcV/U2E6o8fY4NaIQF+J
	C9BnvVS0zfrK+ndvD7m1SxsR1YIo7pEyo5mmI27nVm4Fy8EpeNLYa/FmMggCUFW8Fb4BnJnD/KB
	1dgDu/Dg8AYn5SHPmfJC6OsQ306EL/7koBzr2E8xpKKzY+PjDY5dnJavnUvaeN+hV47dedL6BSP
	BOSilofKybh/kkCfp6X2MRA2PLVz2OZ/xOWdOLjF57+3Ym2zTdxL5cOM6gGUwa2fTzMyqe8mcnL
	J9exrG8AhjoKlAgpVK6NGpQ/xN5vJ+vxb0RWTUSQovFfBI6yPtT0GH963tqUMbcwucTsaqKNTQS
	sw/xRK9iy10LqoVnIKvjg51yeZ+nGHnytm9JrenVmkRBpxX2UfC24IatGaHVbGhcelQZSLwZdGv
	HfY/KZmMWkzTHGAFINHbHysC4FLw4SxxKf4NjqUT/actGfbpnYXJ+GCS+As+88DU2m
X-Google-Smtp-Source: AGHT+IGJMxbepz/DsIkJDRdSCt+wxNFX4J1yCrgWme6EL57yOSAcR9Uz4GAQA0kNYrpk79eoeobmKw==
X-Received: by 2002:a17:907:c994:b0:b80:40d2:9652 with SMTP id a640c23a62f3a-b8040d296a2mr2795548566b.65.1767487730529;
        Sat, 03 Jan 2026 16:48:50 -0800 (PST)
Received: from control-center.fritz.box (150-12-20-31.ftth.glasoperator.nl. [31.20.12.150])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a5bdfesm5104839066b.10.2026.01.03.16.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 16:48:50 -0800 (PST)
From: Tom Geelen <t.f.g.geelen@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alex Kanavin <alex.kanavin@gmail.com>,
	Tom Geelen <t.f.g.geelen@gmail.com>
Subject: [auh][PATCH 3/5] Remove unused imports
Date: Sun,  4 Jan 2026 01:47:01 +0100
Message-ID: <20260104004708.2494403-6-t.f.g.geelen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260104004708.2494403-2-t.f.g.geelen@gmail.com>
References: <20260104004708.2494403-2-t.f.g.geelen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 04 Jan 2026 00:48:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2891

Every file in AUH contains imports that are not used. This patch
removes those unused imports to clean up the code.

---
 modules/buildhistory.py       | 6 ------
 modules/steps.py              | 4 ----
 modules/testimage.py          | 7 -------
 modules/utils/bitbake.py      | 4 ----
 modules/utils/devtool.py      | 2 --
 modules/utils/emailhandler.py | 2 --
 modules/utils/git.py          | 1 -
 7 files changed, 26 deletions(-)

diff --git a/modules/buildhistory.py b/modules/buildhistory.py
index 0c13cb4..407a1e5 100644
--- a/modules/buildhistory.py
+++ b/modules/buildhistory.py
@@ -20,13 +20,7 @@
 #
 
 import os
-import logging as log
-from logging import debug as D
-from logging import info as I
 from logging import warning as W
-from logging import error as E
-from logging import critical as C
-import sys
 
 from errors import *
 from utils.git import Git
diff --git a/modules/steps.py b/modules/steps.py
index 08f47fd..93cb3a6 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -20,16 +20,12 @@
 #
 
 import os
-import sys
-import subprocess
 import shutil
 import re
 
 from logging import debug as D
 from logging import info as I
 from logging import warning as W
-from logging import error as E
-from logging import critical as C
 
 from errors import *
 from buildhistory import BuildHistory
diff --git a/modules/testimage.py b/modules/testimage.py
index 849a9f1..85ee4f3 100644
--- a/modules/testimage.py
+++ b/modules/testimage.py
@@ -22,15 +22,8 @@
 #
 
 import os
-import sys
-import shutil
 
-import logging as log
-from logging import debug as D
 from logging import info as I
-from logging import warning as W
-from logging import error as E
-from logging import critical as C
 
 from errors import *
 from utils.bitbake import *
diff --git a/modules/utils/bitbake.py b/modules/utils/bitbake.py
index 32c234c..ad011db 100644
--- a/modules/utils/bitbake.py
+++ b/modules/utils/bitbake.py
@@ -24,11 +24,7 @@
 #
 
 import os
-import logging as log
-from logging import info as I
 from logging import debug as D
-from logging import error as E
-from logging import critical as C
 import sys
 import re
 
diff --git a/modules/utils/devtool.py b/modules/utils/devtool.py
index b3a9ce7..d4b7ba7 100644
--- a/modules/utils/devtool.py
+++ b/modules/utils/devtool.py
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
-import os
-import logging as log
 from logging import debug as D
 
 from utils.bitbake import *
diff --git a/modules/utils/emailhandler.py b/modules/utils/emailhandler.py
index 1ed4bfc..0629c8f 100644
--- a/modules/utils/emailhandler.py
+++ b/modules/utils/emailhandler.py
@@ -24,7 +24,6 @@
 #
 
 import os
-import logging as log
 from logging import error as E
 from logging import info as I
 from smtplib import SMTP
@@ -33,7 +32,6 @@ from email.mime.text import MIMEText
 from email.mime.application import MIMEApplication
 from email.mime.multipart import MIMEMultipart
 from email.generator import Generator
-import shutil
 from io import StringIO
 
 class Email(object):
diff --git a/modules/utils/git.py b/modules/utils/git.py
index abdcc47..abc1acc 100644
--- a/modules/utils/git.py
+++ b/modules/utils/git.py
@@ -24,7 +24,6 @@
 #
 
 import os
-import logging as log
 from logging import debug as D
 
 from utils.bitbake import *
-- 
2.43.0


