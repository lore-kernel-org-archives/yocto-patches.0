Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1604.1794712791213747881
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Nov 2026 19:19:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=w/+hR6yd;
 spf=pass (domain: gmail.com, ip: 209.85.215.175, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cddac941ed1so1083037a12.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 19:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794712790; x=1795317590; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9J/w84Lthu0JmHERVtF39NnbI9oDf0PfwMcFQPPamaM=;
        b=w/+hR6ydWpZOgn73oQl4Sn3q+d9lq9lV3u+YjK9VhgQNNTpzAxCti4eFI+sJuyBG2b
         IW3oOHhJNs2aIGRgRp6GHuYAoCUtae6Ef55Oye2xCsrb1Iib+miUyqD6eT+10TNSdZ27
         KePZRr4Awo7istWH0f8HgCsx1j51vJSFsLW7ssGEie+beUf8pRjXj958L/aG5SmenttJ
         O1n+RucxE9sojPhmlo982AYYx6afzdJGSTxdMnfamJJq75f7KQwSB6cXzRiZ3TgJRz/R
         qKTCcg9VJ9Jnzr/FgaSYt3OlUBVCGbxh/o//ctcydDODblj9xRLNfumDSghgbTTC8jJP
         Mz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794712790; x=1795317590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9J/w84Lthu0JmHERVtF39NnbI9oDf0PfwMcFQPPamaM=;
        b=1mC//7bBkZ40vVlQirLxxCK8lAFRNHzipHBKwI0EqigoxJd48/JhsYtF16e5xl6ZTn
         i4LoKulkrmgfLnyEni+R7pK59oL6AEZkkZ6eu+/+7OdI5PTx1c90qCgfNZH0hsClz2fu
         /lgzLhwOsn5ESUp26p6AUNDYUFenhm7fIqW3tza+R4Mz55ZUa3jjzQ1kkcsCwFntXiQR
         C6amJDoHIGYB/V4Owj8FdgMHvFIUyg8h5uJIAvcEVdvb9yRa8Sz8dz0gQ6/s2nij9a5z
         Olf4FEIsxjA3tXD3Haz+3ije1+tqhyRlBngg/5It7pcdkb7EdHGDJKIoIJYcqtbGY97s
         bGPA==
X-Gm-Message-State: APuU4Z8Q0Yg/GLe7IkAOwV6wef9fOqQVBVf0Hd6rQFuR/NKkinnyXgQM
	Yr0HByenG8iMxn2tWQ7N3BmnUPH6PbLAt7sQqOae4YkWRwpVoI/MQx9yAAnEIw==
X-Gm-Gg: AYBFou0pH1SC3/7t9sUPFFwn/TUaPc7R+lioGGB8B8f1dk+6chAdCQMG4gH3JJZ2gd9
	jfBs5KK1b8JvNifdt2g4FfYGiAz0slhX8L6Ph83ij9l5hbXvbBkZIxi0baD32ZEKyYnkIP9lCFH
	RzUUXkhVVPJUeEQOKRGwM2XIsygVXfey0RcCWRp5hD4mw8UBS/atI2yv+E0oeTXQFRb0Yg7FrYv
	MkxGn4Mz/PEo3z0b37K6HEP32CHXycjeNfhHqM6KA5AUHA/4FZO9BMF7aJRnmDUARUig1hRUIow
	w6scuR6EnPSKeats7enWcBapZ+7+sZCSUZ9LG884H/wYu5wsR8hPXVTwNZqmL/BpzBFvoy3y62i
	2bg+VfXG0j9ueyWvbXB4rGzMf2alqE9PwM8qgqs9e6OZcNhi6OmtK4xQPQqLWbU05OtJya6oUhk
	Q7cMOgUqy6Vsrn9z+PrgeibxT7HtizcI+PuoDj/EaPBU2SaNCcf9ucgMBpl+cJqCwnAW/e1zkYG
	9kxW5ybrqp0bGkdKSyuApNcZKxKCxCTeH/mSvoSQqEkMoWVkISghWsc2ZzRbDyReIz23v029SGL
	69aEZKx4wBxjeJcKQp6Ai93PMQ98zmUKb/6J2VongqtNk1m8748LtU7NH1ZHFg==
X-Received: by 2002:a05:6a21:790e:b0:3de:517d:fd81 with SMTP id adf61e73a8af0-3f7a87d387amr4513723637.65.1794712790494;
        Sat, 14 Nov 2026 19:19:50 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc1898afbsm2761560a12.19.2026.11.14.19.19.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 19:19:49 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/2] rrs_distros: match python3-* recipes to distro packages
Date: Sat, 14 Nov 2026 19:18:06 -0800
Message-ID: <20261115031803.74076-6-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115031803.74076-2-tim.orling@konsulko.com>
References: <20261115031803.74076-2-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 03:20:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5390
Content-Type: text/plain; charset="utf-8"

OE names Python modules python3-<name>, Fedora and openSUSE name their
source packages python-<name>, and Debian and Ubuntu name the binary
package python3-<name> (which OE-Core's distro_check lists as well,
bug 16512). So almost no python3-* recipe matched a distro. Also look
for python-<name>, and record the name that matched.

The bare <name> isn't tried: it gives false matches such as
python3-lz4 against the lz4 C library.

[YOCTO #16513]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 rrs/tools/rrs_distros.py  | 13 +++++++++----
 tests/test_rrs_distros.py | 10 ++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/rrs/tools/rrs_distros.py b/rrs/tools/rrs_distros.py
index 55f5aeb..8fc7ffb 100755
--- a/rrs/tools/rrs_distros.py
+++ b/rrs/tools/rrs_distros.py
@@ -74,16 +74,21 @@ def search_package_in_distros(pkglst_dir, recipe, data):
         (distro, distro_release) = distro_file.split("-")
 
         if distro.lower() in distro_aliases:
-            pn = distro_aliases[distro.lower()]
+            names = [distro_aliases[distro.lower()]]
         else:
-            pn = recipe_name
+            names = [recipe_name]
+            # Fedora and openSUSE call the source package for a Python
+            # module python-<name>. Debian's lists have the python3-<name>
+            # binary package, which OE-Core's distro_check records too.
+            if recipe_name.startswith('python3-'):
+                names.append('python-' + recipe_name[len('python3-'):])
 
         with open(os.path.join(pkglst_dir, distro_file), "r") as f:
             for line in f:
                 (pkg, section) = line.split(":")
-                if pn == pkg:
+                if pkg in names:
                     distro_complete = distro + "-" + section[:-1]
-                    distros[distro_complete] = pn
+                    distros[distro_complete] = pkg
                     break
 
     return distros
diff --git a/tests/test_rrs_distros.py b/tests/test_rrs_distros.py
index 419b44d..45d1759 100644
--- a/tests/test_rrs_distros.py
+++ b/tests/test_rrs_distros.py
@@ -43,3 +43,13 @@ def test_native_suffix_is_ignored(rrs_distros, pkglst_dir):
 def test_distro_pn_alias(rrs_distros, pkglst_dir):
     assert search(rrs_distros, pkglst_dir, 'liblz4', alias='Debian=lz4 Fedora=lz4') == {'Debian-main': 'lz4', 'Fedora-main': 'lz4'}
 
+
+def test_python3_recipe(rrs_distros, pkglst_dir):
+    # [YOCTO #16513] Debian's list has the python3-brotli binary package,
+    # Fedora's has the python-brotli source package
+    assert search(rrs_distros, pkglst_dir, 'python3-brotli') == {'Debian-main': 'python3-brotli', 'Fedora-main': 'python-brotli'}
+
+
+def test_python3_recipe_not_matched_by_bare_name(rrs_distros, pkglst_dir):
+    # lz4 is the C library, not the Python module
+    assert search(rrs_distros, pkglst_dir, 'python3-lz4') == {}
-- 
2.56.1

