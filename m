Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8385BC44500
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 22:29:35 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.161872.1783376967169044579
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 15:29:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=UOve2KLC;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f256eaedf8so37556396d6.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783376966; x=1783981766; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o/TyJz94mX2i1QV8NCVxcG4VNAPy5W9Tg1kMNh3vuSk=;
        b=UOve2KLCfaXk5Np2DIyDhmCaaBkNej7h4qkJnVndHYGINZc9/Qkce2BTihvXjyK6yZ
         OcbKJF9JgFAlo7+2o32aRys+aiz9CFjjoFBTYyKAiSGeel/BIvXflWHFFftPtXfy85CJ
         sV5MSo/nkkCHdjAEyAYCKA5UF8j1S1sIu4A/H1AqgcSAGmb3fZYPOe084QdLo63THi5O
         lA+t/gHxqQT0gxt0NZ70E8gFyQ3EE9SeR1D6ElmK0jNK1akOtlCvkIBuIhzsoTdg+OC1
         f1SgoQZ+ox/VnDC2JUldHKXNUPZD/31V5qfV+DYr9iEgraLwUB2yW6LFiSpU3oOLHE4F
         O1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376966; x=1783981766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o/TyJz94mX2i1QV8NCVxcG4VNAPy5W9Tg1kMNh3vuSk=;
        b=nfF650wB3JSBhRJkPN+Xr/yDv/nZbjtjz376VWCD5+/bdaYmWhw5zt+L7iST+ULvKo
         MQBvrUKCEae/uRmgtFsXZdzVrVOglYvumJkcelWHQcQZoq0e2cUNidGhutQaO8RUiqB+
         cXUq9yPrStPPolqKBeVIlvrLfVwv/xbcWJQyZi3kUYj7rmz9V8oG5RaMiN/1J+vQvsUc
         ECHldfP+7IuXsvb5lv7nFODTzFKAaww+vVAnrqd+R3JUnDfd1+j9z+A9uuQBf3Wejdc3
         HflBz0tJIrXsD/4YQkUFYPzqxd+IBtlwBJ7e3zNYvmrW+JzbdV+z3eGI12ARPJIZSQse
         fg2A==
X-Gm-Message-State: AOJu0YzTIWUWyNcRglV8xalvBMKtIaTVpWlMmVSOlpbJG3b9Yr2nn6H3
	qOjo327o+/k/L7muIhgWqig7TXcHiLNXQ+RpyS5X7tLh8qzP7t2u/6HtsUkJPK5f
X-Gm-Gg: AfdE7cnEsaQzcsDaZLtpR0kcjbapewUXvTjqj9D6PTChiUfpXoCXFjPigSvoQKowHgM
	lU8C20+6W598H8Z4kxYH55GbMyj8XoPxMpLwlvsO5AYf8VqL2+reCrhpUbdoxl/M3FLkv9rOfNq
	Q1esdXh4JeaO656oMAKsT+zr3L13yesUMg1UGoaZZ+YW6uyO7RFY5H38p/D54Yfebevg6q9kIyj
	kd0e2BHU3h5ZCXej23D7LWlUgpYpgp7/FoPhPanjGURCoq6oWRXU0umVfySvHdzbDLPYL1xYZBe
	vu9TeFHi6Jz8zSXMGWVfF3i4tbya7snrNqe2uH14qK+Xd0V4lTTLeefvgfEEPjDBeRtbzn2CK1Y
	nTdz30ZQgANjtti4zhUmz/4QfJ3QfvBb47e/vEEUQUIaC5ohYqlZZeVI6GHKaDJOIw6g8SVjXKe
	xWi3PYTdoSlTNeLrFrTj5+J8ODcqSGfW8ZsgD+4scDAfioTUj7BF4Y7/w=
X-Received: by 2002:a05:6214:2e4a:b0:8f4:821d:95f7 with SMTP id 6a1803df08f44-8fcb25a90bemr36342116d6.18.1783376965969;
        Mon, 06 Jul 2026 15:29:25 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9d8c0sm143663726d6.49.2026.07.06.15.29.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:29:24 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v4 5/6] bb/utils: import errno so mkdirhier's OSError handler works
Date: Mon,  6 Jul 2026 18:29:03 -0400
Message-ID: <20260706222904.664863-6-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260706222904.664863-1-twoerner@gmail.com>
References: <20260706222904.664863-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 22:29:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4447

mkdirhier() calls os.makedirs(directory, exist_ok=True) and, if that
still raises OSError, re-checks the error before deciding what to do:

    except OSError as e:
        if e.errno != errno.EEXIST or not os.path.isdir(directory):
            raise e

but the module never imports errno. The reference to errno.EEXIST is
only evaluated when os.makedirs() actually raises, so the defect stays
hidden on every ordinary call. The moment a real OSError occurs -- a
parent component that is a file, a permission error, anything -- the
handler itself raises NameError: name 'errno' is not defined, masking
the original error with a misleading one.

Import errno so the handler behaves as intended: it re-raises every real
error, while tolerating only an EEXIST whose path is in fact already a
directory.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v4:
- new commit: the errno import fix now lands on its own, before the
  test that exercises it. In v2 and v3 it was folded into the
  test_bb_utils commit.
---
 src/wic/bb/utils.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/wic/bb/utils.py b/src/wic/bb/utils.py
index 3750056ba563..0b40dd0c1d59 100644
--- a/src/wic/bb/utils.py
+++ b/src/wic/bb/utils.py
@@ -1,6 +1,7 @@
 """
 Minimal subset of BitBake's bb.utils used by standalone wic.
 """
+import errno
 import os
 
 # from bitbake/lib/bb/utils.py
-- 
2.50.0.173.g8b6f19ccfc3a


