Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1596.1794712754518295921
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Nov 2026 19:19:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=k3Y8RVsB;
 spf=pass (domain: gmail.com, ip: 209.85.210.178, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b4c8b51b58so2347859b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 19:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794712754; x=1795317554; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TyGlmTfWInQEPXD6KY+611Vf2W/MDfrV8me1NdVX8nY=;
        b=k3Y8RVsB1Yr8DOCnBS7dDIqvvb4uSButKXDo/BmhikvSEhcu6UXljNr20hQu1ta4kw
         HdqHgS45rfF2XDxnliE33m5j1lcJLJm6BLfFEXrek31g6z15N0RUdf4LxrrjAlYSviyN
         dD28leVOO2O4qW4hOINkuDcrUFLpnhMR4OK/xbFCybq+pYxKHGogxAnsKFRw+oPr1uHW
         8G5UXO50FC/vrelpexfcI18ZopPEx1qfFe8EGq1ajUYhpCSglh8r4M1UIcJeqLq7WDjq
         Of+3YfbeVEU3RRuGHtCE68GKMAD/YgKqds2d2f5Pkrn1Nb8jnrxdfu5nwpcYnTsddTCw
         u0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794712754; x=1795317554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TyGlmTfWInQEPXD6KY+611Vf2W/MDfrV8me1NdVX8nY=;
        b=pIfm4x0KQxjfzADbzPPTfSb/sG/cYzX+nUygtb7an4fmjKeCyJzoo1k7Oh3OgcTDYf
         mMozdUoEcF1m2S3yBVk8g1wTcNeTA5OuAFO25uF/jWGdNTubDgH/QgfnnNB6ANKe7e9b
         1az3ZHA/t3JbqBHpOpz7ZldpzoA/7LQHl5BmgEHHeuWDwP40fY0bQVc/McxNWBPl2n6z
         ryd0a7hCXJqcs3CF/qVolDMnqRMTpJBUqNntehm4gpF5e2JFoqgpQYoP+UgglU3vz9I8
         G01TWhGlY80bTwf3TPgxpTGaxus+HCbg7oPIZjqhHp4ZB/mtmXKzsS1o7o/p1tKSEmao
         9Hkg==
X-Gm-Message-State: APuU4Z8GGQ0E9h9m2S7PxcBrCiAxjXRtp766T/kx9LkfJ4oOYCdDv7EL
	fPHQWE5G4NBkJJHTyAwSmVgABwsVreMnWpRU4a6bNTm9Oz7/mCREV0NyIvVVEw==
X-Gm-Gg: AYBFou13KkPfv3l85Kxr3w33Lmv8G+9Y5PjjG/PhMB8gMtS90JgNwOaUsJUXHW6m82R
	JyCzCmf/QVM7zaB4o3jQm9gy0ru7T/6QdWm3GMZ4UpRaozIVMOEWg3mI8uz4Bcpx8eAofThud54
	1ANleJaa55CaX8LTUwclR4ZJ4USTb/79AVtARVBDu8vRWU8V4M0BfrW4L5OdAp8mp4PNR8BQo2f
	KM7wguLDUEHdkawlCrJ9uzETrhmHNAdad0eLLKRL5IIrCTLRvJsyqdSEp43GhwIM2qmVyiGBGpb
	0D2pIBTae23dyNhB66Ib9sKVMlOxWcXjHlyR9Jcb7pxwDcwv0vvFAes9XPbpZFxSg7RrvXJ/SRc
	rYixQIAWCtBd6V+jvAMYr6xC1EjlAWM1Xe2uZWPILpi75JofCFg6NfK7EUES0Z6lE0LNp1ipjND
	yUZ++W39Owkmy9ni2UOUFj9jbnXkGr9CH1chhkQVuWQfsDuTtspQE3TI+3qMbGWz7OdrV1Z4sCX
	zqYsbEl/BS4oyG94GEx6yWNAKWW6ulHwuzhEDHVwnLw5epn8E06CmuvIx3JSucBbNdvvY6EfV4q
	2UQeTL7qrpUGebIyYwG25/Cm2mZtbueP3xX4MjCasW9lAgrPvpAs6/MKod9wyg==
X-Received: by 2002:a05:6a20:6a1b:b0:3eb:8c85:92b8 with SMTP id adf61e73a8af0-3f7a74c34f2mr7575556637.19.1794712753909;
        Sat, 14 Nov 2026 19:19:13 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc1898afbsm2761560a12.19.2026.11.14.19.19.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 19:19:12 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/2] rrs_distros: strip the native/cross suffixes before matching distro packages
Date: Sat, 14 Nov 2026 19:18:04 -0800
Message-ID: <20261115031803.74076-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115031803.74076-2-tim.orling@konsulko.com>
References: <20261115031803.74076-2-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 03:19:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5389
Content-Type: text/plain; charset="utf-8"

search_package_in_distros() meant to strip nativesdk-, -native, -cross
and -initial from the recipe name, but discarded the result of
str.replace(). Keep it.

[YOCTO #16513]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 rrs/tools/rrs_distros.py  |  2 +-
 tests/test_rrs_distros.py | 45 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 tests/test_rrs_distros.py

diff --git a/rrs/tools/rrs_distros.py b/rrs/tools/rrs_distros.py
index 3dc745d..55f5aeb 100755
--- a/rrs/tools/rrs_distros.py
+++ b/rrs/tools/rrs_distros.py
@@ -59,7 +59,7 @@ def search_package_in_distros(pkglst_dir, recipe, data):
 
     removes = ['nativesdk-', '-native', '-cross', '-initial']
     for r in removes:
-        recipe_name.replace(r, '')
+        recipe_name = recipe_name.replace(r, '')
 
     distro_alias = data.getVar('DISTRO_PN_ALIAS', True)
     if distro_alias:
diff --git a/tests/test_rrs_distros.py b/tests/test_rrs_distros.py
new file mode 100644
index 0000000..419b44d
--- /dev/null
+++ b/tests/test_rrs_distros.py
@@ -0,0 +1,45 @@
+# layerindex-web - tests for matching recipes to distro packages in rrs/tools/rrs_distros.py
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import os
+import sys
+import types
+
+import pytest
+
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'rrs', 'tools'))
+
+
+@pytest.fixture
+def rrs_distros(monkeypatch):
+    # The test settings don't install the rrs app, which the script imports
+    monkeypatch.setitem(sys.modules, 'rrs.models', types.SimpleNamespace(RecipeDistro=None, MaintenancePlan=None))
+    monkeypatch.delitem(sys.modules, 'rrs_distros', raising=False)
+    import rrs_distros
+    return rrs_distros
+
+
+@pytest.fixture
+def pkglst_dir(tmp_path):
+    # Package lists as OE-Core's distro_check writes them: <distro>-<release>, "<name>:<section>" lines
+    (tmp_path / 'Debian-13.7').write_text('brotli:main\npython3-brotli:main\nlz4:main\nfoo:main\n')
+    (tmp_path / 'Fedora-45').write_text('python-brotli:main\nlz4:main\n')
+    return tmp_path
+
+
+def search(rrs_distros, pkglst_dir, pn, alias=None):
+    recipe = types.SimpleNamespace(pn=pn)
+    data = types.SimpleNamespace(getVar=lambda name, expand=True: alias if name == 'DISTRO_PN_ALIAS' else None)
+    return rrs_distros.search_package_in_distros(str(pkglst_dir), recipe, data)
+
+
+def test_native_suffix_is_ignored(rrs_distros, pkglst_dir):
+    assert search(rrs_distros, pkglst_dir, 'foo-native') == {'Debian-main': 'foo'}
+
+
+def test_distro_pn_alias(rrs_distros, pkglst_dir):
+    assert search(rrs_distros, pkglst_dir, 'liblz4', alias='Debian=lz4 Fedora=lz4') == {'Debian-main': 'lz4', 'Fedora-main': 'lz4'}
+
-- 
2.56.1

