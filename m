Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450BCC35FFB
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 12:35:41 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.6739.1742387738100840442
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Mar 2025 05:35:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NJ9TTyHs;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a823036so41539405e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Mar 2025 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742387736; x=1742992536; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VkRecwYMR7wqyl366CwYLM+IT2nnBSjynIQqowT6B+Y=;
        b=NJ9TTyHsMd8/kySY2+mY9oF407mDcivFTUs2Y/XjVVUhPhGNY6UJ1Aycmq/L1dF5gp
         F8QSvtZFLuwFkVbVeSZJstbmzl7JX2Bf+oRZ8eqRd9EHTesLTfK0Zu5TBhxemQgmNwZd
         EH5juAKp5KdT12LFpgNrVw9ICZ55+InROEl6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742387736; x=1742992536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkRecwYMR7wqyl366CwYLM+IT2nnBSjynIQqowT6B+Y=;
        b=nWDzfhsCkL/bKp45ebIj3yoReMldQmHET/CcfgnUFLo5gWS4MO5x7ECj5CF8vIfYHn
         gkhENAkPbdQgGNeh5QHi30lRClIIw7kQql1+sm9qYjwmHrvFMrbvq6YdPbsU/aThS4Fm
         iUNB2AyNTcQZcN/EmWnj+z6rD3ySXl1H803zzRbUxI7RtM0f9jsOKB6bgWsBi6J0JbNg
         nqD2JaQL09IbaUmw13IfFu6auTuRY0yRElU5i46v4IDo9A0XUOxFvv+xU+WZM3ljU8EG
         llngNd/R0/1QvCEEc5ddkftlhMyIo0RJtdUfOdoHXhMV+ASnplgRCA47fNZJCGaoTKsx
         lkWQ==
X-Gm-Message-State: AOJu0YxbF8zFTqrt4rcxL0g8Om/5ytDIcSnumN+9ewU6NIDzHOd7Pgac
	fR1LbeR7VxS/xAYJ0Kt743+KUM2tOShHc2I2yKMJyo5ntN7TphUIr6WObDKBqs1A0k4sbxplDjC
	l
X-Gm-Gg: ASbGncuhZW+Dg8OYcVEMSut+VYNE84d6c33FeYQi7Q9npGuuTuUZ8Aphzu855cJYhKW
	qjFDtGFFBDvogG2UfIhXpZpQtbvycjgtog0Qqy1GdKrxYzgDNbXpCKtZk6sPjrwBOLaJQDXCx7w
	PlxZyqHrYvRcom9T7DzCKQHNVW1HZoqvo25W5U57MvaBGIy8W9+gEEmvecEe1Ybt97jkw3DhQOc
	RtpnkcgA1eY0g224m6aeROhmDhgZcGf63ld2N3ZWVpSa//jLSk6wm5qzuAAmn4qKiW79m3zr1so
	6YzHOmmxLYfyIxHNxBQtOaHhezv3rto484N9OBa06pJZo8YivYWKWHB4q22j0VnGv5AlPeaO
X-Google-Smtp-Source: AGHT+IE0qV4W0qJFR93O3gS4qbVYEwYR9tFgy7bGDDCyBL6r1y87sTgyX7e1bQSYJTjkAJU9XvY8tQ==
X-Received: by 2002:a05:6000:1a87:b0:391:48d4:bd02 with SMTP id ffacd0b85a97d-399739d7c73mr1994699f8f.29.1742387734970;
        Wed, 19 Mar 2025 05:35:34 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:dad:b471:9c34:4577])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c4f9d59dsm20929419f8f.0.2025.03.19.05.35.33
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:35:34 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [libmatchbox] [PATCH 1/2] Clean up licence headers/files to use SPDX
Date: Wed, 19 Mar 2025 12:35:23 +0000
Message-ID: <20250319123532.642335-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Mar 2025 12:35:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1221

Switch the headers on files for SPDX license identifiers, which is
LGPL-2.0-only in most cases.

The COPYING.MIT is HPND in SPDX so rename that and apply the appropriate
license identifer for those files.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 COPYING.MIT => COPYING.HPND |  0
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
 24 files changed, 38 insertions(+), 260 deletions(-)
 rename COPYING.MIT => COPYING.HPND (100%)

diff --git a/COPYING.MIT b/COPYING.HPND
similarity index 100%
rename from COPYING.MIT
rename to COPYING.HPND
diff --git a/libmb/hash.c b/libmb/hash.c
index a867883..aa4340e 100644
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
+ * SPDX-License-Identifier: LGPL-2.0-only
  */
 
 #define _GNU_SOURCE
diff --git a/libmb/hash.h b/libmb/hash.h
index 43827b2..26bbb0c 100644
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
+ * SPDX-License-Identifier: LGPL-2.0-only
  */
 
 #include <stdio.h>
diff --git a/libmb/mb.h b/libmb/mb.h
index 4e1cc34..ecddb88 100644
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
+ * SPDX-License-Identifier: LGPL-2.0-only
  */
 
 #ifndef _MB_H_
diff --git a/libmb/mbdotdesktop.c b/libmb/mbdotdesktop.c
index a95360d..e7da084 100644
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
+ * SPDX-License-Identifier: LGPL-2.0-only
  */
 
 #define _GNU_SOURCE
diff --git a/libmb/mbdotdesktop.h b/libmb/mbdotdesktop.h
index 13c762b..725c185 100644
--- a/libmb/mbdotdesktop.h
+++ b/libmb/mbdotdesktop.h
@@ -1,3 +1,7 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.0-only
+ */
+
 #ifndef _MBDOTDESKTOP_H_
 #define _MBDOTDESKTOP_H_
 
diff --git a/libmb/mbexp.c b/libmb/mbexp.c
index bbe11d0..fabe544 100644
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
+ * SPDX-License-Identifier: LGPL-2.0-only
  */
 
 #define _GNU_SOURCE
diff --git a/libmb/mbexp.h b/libmb/mbexp.h
index d3071c6..a030e7c 100644
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
+ * SPDX-License-Identifier: LGPL-2.0-only
  */
 
 /* 
diff --git a/libmb/mbmenu.c b/libmb/mbmenu.c
index 286ea0b..756cec8 100644
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
+ * SPDX-License-Identifier: LGPL-2.0-only
  */
 
 #define _GNU_SOURCE
diff --git a/libmb/mbmenu.h b/libmb/mbmenu.h
index 1393ab2..bdfc5be 100644
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
+ * SPDX-License-Identifier: LGPL-2.0-only
  */
 
 #include <libmb/mbconfig.h>
diff --git a/libmb/mbpixbuf.c b/libmb/mbpixbuf.c
index a8ee2e9..2b4f67a 100644
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
+ * SPDX-License-Identifier: LGPL-2.0-only
  */
 
 #define _GNU_SOURCE
diff --git a/libmb/mbpixbuf.h b/libmb/mbpixbuf.h
index 750262f..fb34694 100644
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
+ * SPDX-License-Identifier: LGPL-2.0-only
  */
 
 #include <libmb/mbconfig.h>
diff --git a/libmb/mbtray.c b/libmb/mbtray.c
index 7207ea8..f91b9d6 100644
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
+ * SPDX-License-Identifier: LGPL-2.0-only
  */
 
 /* 
diff --git a/libmb/mbtray.h b/libmb/mbtray.h
index 3b60e2f..87a3576 100644
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
+ * SPDX-License-Identifier: LGPL-2.0-only
  */
 
 #ifndef _MB_TRAY_H_
diff --git a/libmb/mbutil.c b/libmb/mbutil.c
index db1f921..49aaf83 100644
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
+ * SPDX-License-Identifier: LGPL-2.0-only
  */
 
 #define _GNU_SOURCE   /* X11.pc sets -DXOPEN flag which this works round */
diff --git a/libmb/mbutil.h b/libmb/mbutil.h
index 44785f2..45b8566 100644
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
+ * SPDX-License-Identifier: LGPL-2.0-only
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
index 28d7880..5826506 100644
--- a/tests/dot-desktop.c
+++ b/tests/dot-desktop.c
@@ -2,6 +2,10 @@
 #include <config.h>
 #endif
 
+/*
+ * SPDX-License-Identifier: LGPL-2.0-only
+ */
+
 #include <check.h>
 #include <stdlib.h>
 #include <libmb/mb.h>
diff --git a/tests/dump-image.c b/tests/dump-image.c
index 2ddadb9..580509b 100644
--- a/tests/dump-image.c
+++ b/tests/dump-image.c
@@ -1,6 +1,10 @@
 #include <stdio.h>
 #include <libmb/mb.h>
 
+/*
+ * SPDX-License-Identifier: LGPL-2.0-only
+ */
+
 void dump(MBPixbufImage *image, const char* symbol)
 {
   int i;
diff --git a/tests/pixbuf.c b/tests/pixbuf.c
index e6640f8..5047862 100644
--- a/tests/pixbuf.c
+++ b/tests/pixbuf.c
@@ -1,3 +1,7 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.0-only
+ */
+
 /* TODO:
  * mb_pixbuf_img_new_from_int_data
  * palette-based images
diff --git a/tests/unicode.c b/tests/unicode.c
index e5d6333..3d47c5f 100644
--- a/tests/unicode.c
+++ b/tests/unicode.c
@@ -2,6 +2,10 @@
 #include <config.h>
 #endif
 
+/*
+ * SPDX-License-Identifier: LGPL-2.0-only
+ */
+
 #include <check.h>
 #include <stdlib.h>
 

