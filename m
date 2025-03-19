Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6767CC35FFB
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 12:57:41 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.7122.1742389053546226423
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Mar 2025 05:57:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dV/aHK5C;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39133f709f5so4201944f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Mar 2025 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742389051; x=1742993851; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CdXRtA6hftHPQbsPYb7FxScjGE7ZC73n44qV17W2yMk=;
        b=dV/aHK5CCKxpbFpkeI96KHgDjzfmHrHuHjhGIw96w/nc4yDxuw1Wo3dcNuCqKAjoDB
         DbqfBmK7f9eJ5Fj/Q4d9KyoWtKAL6CejwoNfbteQouTq5gABomPL+P6SHrMIZ9txZQbm
         aQiR9YtIU5c+4k4sOvauxgrzr4f7xNE0/aR/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742389051; x=1742993851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdXRtA6hftHPQbsPYb7FxScjGE7ZC73n44qV17W2yMk=;
        b=FDCklpKdP3BNg4eGkBZNzxfzjGzC0gqKQWOjCx/77aH2vzIpQgamtcHI1tFeTaXSHy
         hsvLUGn/G6gReBZtFoh72rF7lyFzGNCCakOSEbpCgw8M5zTb1mWpI+YsRS9A6ZYZTOFw
         bGQORPnIKRUpZiNaMkPeHZDumCqfrdd+d6L8iueQDTEI3VgV2zRUopC6pHMpt4k88evA
         3fDmcHkmp+dNF8504z48qHxiR881FP7XMMdtWyq67C6xZIrE3z33uB8zyWUKr4eN2MLU
         YTiYmizpq358zPoiRdSU7lY/Fo86giBNVXl7EftSISNDTzCvqswAa0IeEJuKtWqHTy84
         tkQA==
X-Gm-Message-State: AOJu0YyV4Z1E/EQ7tyEIjG3ROHSqfY1rker5EkzDu96zeugPFKZekrHP
	cp4gHfyduY8lYxdPLtEoaEJpBRQu9mqo5fyHTjfI5EcpOKQtfpWu0Y3LMVr75U+9b6maHuK83mp
	4
X-Gm-Gg: ASbGncsOQviR6YVKd4aSrQNcWkK0O5dd88Q2SvIwezd1D9MYQH9dK4qsYcaPBwK0K8Z
	gt7+DO2+QomgINgz7QqF0/A02IFwuMbIUjEQkZDWVmb7VBRE9YYPN+vlWK/kRlr8GiTRTQb19mq
	NkA3rkUb+LmZdLAQnuFnH/DZDvN02PiBwcTMQ7YIzX4UnCboIFBJsFIYo/jQ5a7i7LHtHLvsZSI
	RaoshyjE4ccBHzRaXqEJy1YXQH+jHMueOHSrXC1R9QimD/48aGXVh+s9946kBBzHD+vVNvf8l9V
	U2McOeB6wnnZbQI7HcmIqq01eaZz9jSIWuoMFcnJJIn079QLh7Z6TAhmxrv8Lk2uLSxPVb8e
X-Google-Smtp-Source: AGHT+IFUQTk6trI6gofPgyenfS1ro613BroejXxPfCng3JzlLBt2ZXDNkojPHINViV/FlYjsALwhNA==
X-Received: by 2002:a05:6000:18af:b0:391:20ef:62d6 with SMTP id ffacd0b85a97d-399739b68f1mr1993394f8f.11.1742389050027;
        Wed, 19 Mar 2025 05:57:30 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:dad:b471:9c34:4577])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7e9f8asm20808886f8f.81.2025.03.19.05.57.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:57:29 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [libmatchbox] [PATCH v2 1/2] Clean up licence headers/files to use SPDX
Date: Wed, 19 Mar 2025 12:57:26 +0000
Message-ID: <20250319125728.646406-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Mar 2025 12:57:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1224

Switch the headers on files for SPDX license identifiers, which is
LGPL-2.0-or-later in most cases.

The COPYING.MIT is HPND in SPDX so rename that and apply the appropriate
license identifer for those files.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 COPYING                     |  2 ++
 COPYING.MIT => COPYING.HPND |  2 ++
 libmb/hash.c                | 15 +--------------
 libmb/hash.h                | 15 +--------------
 libmb/mb.h                  | 15 +--------------
 libmb/mbdotdesktop.c        | 15 +--------------
 libmb/mbdotdesktop.h        |  4 ++++
 libmb/mbexp.c               | 15 +--------------
 libmb/mbexp.h               | 15 +--------------
 libmb/mbmenu.c              | 15 +--------------
 libmb/mbmenu.h              | 15 +--------------
 libmb/mbpixbuf.c            | 15 +--------------
 libmb/mbpixbuf.h            | 15 +--------------
 libmb/mbtray.c              | 15 +--------------
 libmb/mbtray.h              | 15 +--------------
 libmb/mbutil.c              | 15 +--------------
 libmb/mbutil.h              | 15 +--------------
 libmb/xsettings-client.c    | 17 +----------------
 libmb/xsettings-client.h    | 17 +----------------
 libmb/xsettings-common.c    | 17 +----------------
 libmb/xsettings-common.h    | 17 +----------------
 tests/dot-desktop.c         |  4 ++++
 tests/dump-image.c          |  4 ++++
 tests/pixbuf.c              |  4 ++++
 tests/unicode.c             |  4 ++++
 25 files changed, 42 insertions(+), 260 deletions(-)
 rename COPYING.MIT => COPYING.HPND (97%)

diff --git a/COPYING b/COPYING
index b1e3f5a..fda8cd9 100644
--- a/COPYING
+++ b/COPYING
@@ -1,3 +1,5 @@
+SPDX-License-Identifier: LGPL-2.0-or-later
+
 		  GNU LESSER GENERAL PUBLIC LICENSE
 		       Version 2.1, February 1999
 
diff --git a/COPYING.MIT b/COPYING.HPND
similarity index 97%
rename from COPYING.MIT
rename to COPYING.HPND
index f7bdbba..8c2fe29 100644
--- a/COPYING.MIT
+++ b/COPYING.HPND
@@ -1,3 +1,5 @@
+SPDX-License-Identifier: HPND
+
 This license applies to libmb/xsettings-*:
 
  * Permission to use, copy, modify, distribute, and sell this software and its
diff --git a/libmb/hash.c b/libmb/hash.c
index a867883..5cb1667 100644
--- a/libmb/hash.c
+++ b/libmb/hash.c
@@ -1,20 +1,7 @@
 /* libmb
  * Copyright (C) 2002 Matthew Allum
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA.
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #define _GNU_SOURCE
diff --git a/libmb/hash.h b/libmb/hash.h
index 43827b2..ee482cf 100644
--- a/libmb/hash.h
+++ b/libmb/hash.h
@@ -1,20 +1,7 @@
 /* libmb
  * Copyright (C) 2002 Matthew Allum
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA.
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #include <stdio.h>
diff --git a/libmb/mb.h b/libmb/mb.h
index 4e1cc34..600518c 100644
--- a/libmb/mb.h
+++ b/libmb/mb.h
@@ -1,20 +1,7 @@
 /* libmb - A library of utility functions used by matchbox utilitys
  * Copyright (C) 2003 Matthew Allum
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA.
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef _MB_H_
diff --git a/libmb/mbdotdesktop.c b/libmb/mbdotdesktop.c
index a95360d..19cb12c 100644
--- a/libmb/mbdotdesktop.c
+++ b/libmb/mbdotdesktop.c
@@ -2,20 +2,7 @@
  *
  * Copyright (C) 2002 Matthew Allum
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA.
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #define _GNU_SOURCE
diff --git a/libmb/mbdotdesktop.h b/libmb/mbdotdesktop.h
index 13c762b..cb95153 100644
--- a/libmb/mbdotdesktop.h
+++ b/libmb/mbdotdesktop.h
@@ -1,3 +1,7 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.0-or-later
+ */
+
 #ifndef _MBDOTDESKTOP_H_
 #define _MBDOTDESKTOP_H_
 
diff --git a/libmb/mbexp.c b/libmb/mbexp.c
index bbe11d0..61eb73e 100644
--- a/libmb/mbexp.c
+++ b/libmb/mbexp.c
@@ -1,20 +1,7 @@
 /* libmb
  * Copyright (C) 2002 Matthew Allum
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA.
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #define _GNU_SOURCE
diff --git a/libmb/mbexp.h b/libmb/mbexp.h
index d3071c6..b0bddb6 100644
--- a/libmb/mbexp.h
+++ b/libmb/mbexp.h
@@ -1,20 +1,7 @@
 /* libmb
  * Copyright (C) 2002 Matthew Allum
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA.
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 /* 
diff --git a/libmb/mbmenu.c b/libmb/mbmenu.c
index 286ea0b..48165a0 100644
--- a/libmb/mbmenu.c
+++ b/libmb/mbmenu.c
@@ -1,20 +1,7 @@
 /* libmb
  * Copyright (C) 2002 Matthew Allum
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA.
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #define _GNU_SOURCE
diff --git a/libmb/mbmenu.h b/libmb/mbmenu.h
index 1393ab2..4c48bb3 100644
--- a/libmb/mbmenu.h
+++ b/libmb/mbmenu.h
@@ -4,20 +4,7 @@
 /* libmb
  * Copyright (C) 2002 Matthew Allum
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA.
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #include <libmb/mbconfig.h>
diff --git a/libmb/mbpixbuf.c b/libmb/mbpixbuf.c
index a8ee2e9..f96ee40 100644
--- a/libmb/mbpixbuf.c
+++ b/libmb/mbpixbuf.c
@@ -2,20 +2,7 @@
  *
  * Copyright (C) 2002 Matthew Allum
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA.
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #define _GNU_SOURCE
diff --git a/libmb/mbpixbuf.h b/libmb/mbpixbuf.h
index 750262f..efdccd4 100644
--- a/libmb/mbpixbuf.h
+++ b/libmb/mbpixbuf.h
@@ -4,20 +4,7 @@
 /* libmb
  * Copyright (C) 2002 Matthew Allum
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA.
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #include <libmb/mbconfig.h>
diff --git a/libmb/mbtray.c b/libmb/mbtray.c
index 7207ea8..3d567a0 100644
--- a/libmb/mbtray.c
+++ b/libmb/mbtray.c
@@ -1,20 +1,7 @@
 /* libmbdock 
  * Copyright (C) 2002 Matthew Allum
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA.
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 /* 
diff --git a/libmb/mbtray.h b/libmb/mbtray.h
index 3b60e2f..b3c0fee 100644
--- a/libmb/mbtray.h
+++ b/libmb/mbtray.h
@@ -1,20 +1,7 @@
 /* libmb
  * Copyright (C) 2002 Matthew Allum
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA.
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef _MB_TRAY_H_
diff --git a/libmb/mbutil.c b/libmb/mbutil.c
index db1f921..b09952b 100644
--- a/libmb/mbutil.c
+++ b/libmb/mbutil.c
@@ -1,20 +1,7 @@
 /* libmb
  * Copyright (C) 2002 Matthew Allum
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA.
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #define _GNU_SOURCE   /* X11.pc sets -DXOPEN flag which this works round */
diff --git a/libmb/mbutil.h b/libmb/mbutil.h
index 44785f2..cc2f6d8 100644
--- a/libmb/mbutil.h
+++ b/libmb/mbutil.h
@@ -4,20 +4,7 @@
 /* libmb
  * Copyright (C) 2002 Matthew Allum
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA.
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #include <stdio.h>
diff --git a/libmb/xsettings-client.c b/libmb/xsettings-client.c
index 50c33ce..af38d53 100644
--- a/libmb/xsettings-client.c
+++ b/libmb/xsettings-client.c
@@ -1,22 +1,7 @@
 /*
  * Copyright © 2001 Red Hat, Inc.
  *
- * Permission to use, copy, modify, distribute, and sell this software and its
- * documentation for any purpose is hereby granted without fee, provided that
- * the above copyright notice appear in all copies and that both that
- * copyright notice and this permission notice appear in supporting
- * documentation, and that the name of Red Hat not be used in advertising or
- * publicity pertaining to distribution of the software without specific,
- * written prior permission.  Red Hat makes no representations about the
- * suitability of this software for any purpose.  It is provided "as is"
- * without express or implied warranty.
- *
- * RED HAT DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL RED HAT
- * BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN 
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ * SPDX-License-Identifier: HPND
  *
  * Author:  Owen Taylor, Red Hat, Inc.
  */
diff --git a/libmb/xsettings-client.h b/libmb/xsettings-client.h
index b916eba..759ecbd 100644
--- a/libmb/xsettings-client.h
+++ b/libmb/xsettings-client.h
@@ -1,22 +1,7 @@
 /*
  * Copyright © 2001 Red Hat, Inc.
  *
- * Permission to use, copy, modify, distribute, and sell this software and its
- * documentation for any purpose is hereby granted without fee, provided that
- * the above copyright notice appear in all copies and that both that
- * copyright notice and this permission notice appear in supporting
- * documentation, and that the name of Red Hat not be used in advertising or
- * publicity pertaining to distribution of the software without specific,
- * written prior permission.  Red Hat makes no representations about the
- * suitability of this software for any purpose.  It is provided "as is"
- * without express or implied warranty.
- *
- * RED HAT DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL RED HAT
- * BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN 
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ * SPDX-License-Identifier: HPND
  *
  * Author:  Owen Taylor, Red Hat, Inc.
  */
diff --git a/libmb/xsettings-common.c b/libmb/xsettings-common.c
index 3d74440..7eeaa4c 100644
--- a/libmb/xsettings-common.c
+++ b/libmb/xsettings-common.c
@@ -1,22 +1,7 @@
 /*
  * Copyright © 2001 Red Hat, Inc.
  *
- * Permission to use, copy, modify, distribute, and sell this software and its
- * documentation for any purpose is hereby granted without fee, provided that
- * the above copyright notice appear in all copies and that both that
- * copyright notice and this permission notice appear in supporting
- * documentation, and that the name of Red Hat not be used in advertising or
- * publicity pertaining to distribution of the software without specific,
- * written prior permission.  Red Hat makes no representations about the
- * suitability of this software for any purpose.  It is provided "as is"
- * without express or implied warranty.
- *
- * RED HAT DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL RED HAT
- * BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN 
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ * SPDX-License-Identifier: HPND
  *
  * Author:  Owen Taylor, Red Hat, Inc.
  */
diff --git a/libmb/xsettings-common.h b/libmb/xsettings-common.h
index e3af4a6..e2e2225 100644
--- a/libmb/xsettings-common.h
+++ b/libmb/xsettings-common.h
@@ -1,22 +1,7 @@
 /*
  * Copyright © 2001 Red Hat, Inc.
  *
- * Permission to use, copy, modify, distribute, and sell this software and its
- * documentation for any purpose is hereby granted without fee, provided that
- * the above copyright notice appear in all copies and that both that
- * copyright notice and this permission notice appear in supporting
- * documentation, and that the name of Red Hat not be used in advertising or
- * publicity pertaining to distribution of the software without specific,
- * written prior permission.  Red Hat makes no representations about the
- * suitability of this software for any purpose.  It is provided "as is"
- * without express or implied warranty.
- *
- * RED HAT DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL RED HAT
- * BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN 
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ * SPDX-License-Identifier: HPND
  *
  * Author:  Owen Taylor, Red Hat, Inc.
  */
diff --git a/tests/dot-desktop.c b/tests/dot-desktop.c
index 28d7880..e14282f 100644
--- a/tests/dot-desktop.c
+++ b/tests/dot-desktop.c
@@ -2,6 +2,10 @@
 #include <config.h>
 #endif
 
+/*
+ * SPDX-License-Identifier: LGPL-2.0-or-later
+ */
+
 #include <check.h>
 #include <stdlib.h>
 #include <libmb/mb.h>
diff --git a/tests/dump-image.c b/tests/dump-image.c
index 2ddadb9..4b71ed3 100644
--- a/tests/dump-image.c
+++ b/tests/dump-image.c
@@ -1,6 +1,10 @@
 #include <stdio.h>
 #include <libmb/mb.h>
 
+/*
+ * SPDX-License-Identifier: LGPL-2.0-or-later
+ */
+
 void dump(MBPixbufImage *image, const char* symbol)
 {
   int i;
diff --git a/tests/pixbuf.c b/tests/pixbuf.c
index e6640f8..517b88f 100644
--- a/tests/pixbuf.c
+++ b/tests/pixbuf.c
@@ -1,3 +1,7 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.0-or-later
+ */
+
 /* TODO:
  * mb_pixbuf_img_new_from_int_data
  * palette-based images
diff --git a/tests/unicode.c b/tests/unicode.c
index e5d6333..32a46cf 100644
--- a/tests/unicode.c
+++ b/tests/unicode.c
@@ -2,6 +2,10 @@
 #include <config.h>
 #endif
 
+/*
+ * SPDX-License-Identifier: LGPL-2.0-or-later
+ */
+
 #include <check.h>
 #include <stdlib.h>
 

