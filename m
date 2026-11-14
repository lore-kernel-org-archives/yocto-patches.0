Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6300.1794633909910714189
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 21:25:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=Fi2M2AtU;
 spf=pass (domain: gmail.com, ip: 209.85.215.173, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso642588a12.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 21:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794633909; x=1795238709; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S+u4F0kawR3lT8j5FvJDeRAxF8Qfb8qH0icgMJrWglk=;
        b=Fi2M2AtUxu7C2xArc/JF3PEzOWP7ocPvxoqRSAXQuTMWUkTat0xJW0y7zlUOqW8OMx
         jJjsf1fBGJ7sC+yeflX/dKrslcTuyTn/saWqLKV67mBmomDqtUhzt/LR6hWNy7AkbHnA
         dQqqfmf7KBKoB/FTbWRTVq4cej/Znj8icNaxWdmIFq06nOzhvmF5ORVkxjaaw6BK1TUj
         2/5vmDvgEFgepMTlM8bMSuGBlaQUZZD0S0vkQG33zMxbPi9qX3MaWhNZ5VRIVfYkh80R
         AZTprZ5wcZZW5E0g7x+M2Sxp8W01K1y6Wf1K5tuAjP1wXfs6T9H+q5NPXWAwemFyFyTw
         ptcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633909; x=1795238709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S+u4F0kawR3lT8j5FvJDeRAxF8Qfb8qH0icgMJrWglk=;
        b=T1672Xs3QeA7haCFaeSL59d7HTNwkDtbgvEZN5tfs4quvjWNvK5PVlDA+n4KAkdbNI
         3DPBOb3UqzJaL73UgroLtNkO3zpeTXYL+BECvFlc8Val5n2HO/K7LXPU76LxFFosAyak
         IH8FplkMMG9rG1eMGUiNeDRHix2ITqMFQ6r7TmVOkXWbokxQ2Az/wYS8y4/Sx7MQRDSa
         zbwtRDaD4KhP/F9J4y+7mpQZAEDHv4R6lqe6nFZ0s7aOAAYxlEWITTksU8Wz48YDXJEH
         e45Inso8I80ctj6CKx08KwHGw9C7CyT+WqpcCkPJh//K64OsioSkEZJUNFQxmGKD0Mst
         1EsQ==
X-Gm-Message-State: APuU4Z+ve47LR0b/XXcLHPpSQkPwGF6Bj7tlYF4UZj+Ki4Ir2H4dVcAq
	SSdDoUpyLcsw3Ry77+shnxPBwTcoW76LXk7EypKOcJ5HwYbHggKjCnF/c1r+VEi9
X-Gm-Gg: AYBFou1sKCLZgrnP8J77hRkLE4a7muquGDWv5Rgm5o7OE75ECz7x2HwVsrI4faqnSTC
	DOUQ8JLf06CF8B/hydRud2ir64BFV7D8od20RVnI8++YBkHC5EOQEScVyONjYEaHPHZpXjzZbXV
	w0gZjIDKobV7HN7jIQGf1DqQR53WiEFarNOHQBDXNxyT3E1kSKxFzkiq+mcXHF59Im9LMqi/gR4
	Hn/TsPjjWaMVn7dIGj9JKgAa9IIYNZ1eJTCiUpQUR2juzrB5wa5qZqFqUI/8h95gQu9UECPQAaP
	KQ3+ujG8qrK/SxT9h+IB4aRCjuwpKEWN/Tzz3ZLLJQEfcek+xCkNBRvZKkrKA/mgIqHXvraOClD
	JTgg4Tt9pUpNhf0OlCYvwxaOPdZj8kNtO/6oqgiUCcTB4g9CuOTDKogK/xh2X5oDWkjD+oMsWOc
	jgu/vFV3dsvlXjM/sy1XFKINAmcMFv85EMJCn4NwSO2lHDAeZKrbA8NDXHBEH5pilZiN81I6i0S
	D3lCeUz+l8xRfdj8gRbt1onTPVOs3blRGunOii6kLmI0aRb7I1uXPiCMXg3wh8FunBpAJ0fEui3
	COa0U0G/aLmIq9TpTs3M5nJef1ik39LIOphMii3N6Y2wdk+ZqpkvyXpeNGnFfpulM13iZfbc593
	woTDCbY4=
X-Received: by 2002:a17:90b:4e8f:b0:3ac:9c37:942e with SMTP id 98e67ed59e1d1-3b1b0b53e79mr4789739a91.49.1794633908874;
        Fri, 13 Nov 2026 21:25:08 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce55c1sm12613097a91.3.2026.11.13.21.25.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 21:25:08 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] update: disable updates for a layer branch whose layer has gone
Date: Fri, 13 Nov 2026 21:25:04 -0800
Message-ID: <20261114052504.96229-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 05:25:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5368
Content-Type: text/plain; charset="utf-8"

When a layer was removed from a branch (its subdirectory or its
conf/layer.conf gone), every update kept trying it and recording the
same error, until an admin deleted the layer branch. Disable updates
for the layer branch instead, and say so in the error. Unlike deleting
it, this keeps the layer branch's data and can be undone; the layer
pages show it as not updated.

[YOCTO #12922]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
This applies on top of "[PATCH 0/3] Report problems with the first
parse of a layer" (bugs 12130, 13490, 13489), which records these
errors against the layer, and on master-next. It disables updates
rather than deleting the layer branch, as discussed in the bug.

On a test instance loaded with a copy of the layers.openembedded.org
database, none of the last three updates hit these errors, so it would
not disable any layer branch today.

 layerindex/update.py | 21 +++++++++++++++++----
 tests/test_update.py | 11 ++++++++---
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/layerindex/update.py b/layerindex/update.py
index dd794dd..72bad6c 100755
--- a/layerindex/update.py
+++ b/layerindex/update.py
@@ -128,7 +128,7 @@ def print_subdir_error(newbranch, layername, vcs_subdir, branchdesc):
     if newbranch:
         logger.info("Skipping update of layer %s for branch %s - subdirectory %s does not exist on this branch" % (layername, branchdesc, vcs_subdir))
     elif vcs_subdir:
-        return "Subdirectory for layer %s does not exist on branch %s - if this is legitimate, the layer branch record should be deleted" % (layername, branchdesc)
+        return "Subdirectory %s for layer %s does not exist on branch %s" % (vcs_subdir, layername, branchdesc)
     return None
 
 def extract_value(valuename, output):
@@ -291,6 +291,15 @@ def main():
         if not options.dryrun:
             layerupdate.save()
 
+    def disable_layerbranch_updates(layer, branchobj, layerbranch, msg):
+        """The layer has gone from this branch: record why and stop updating
+        it. Unlike deleting the layer branch, this keeps its data and can be
+        undone by enabling updates again."""
+        if not options.dryrun:
+            layerbranch.updates_enabled = False
+            layerbranch.save(update_fields=['updates_enabled'])
+        record_layer_error(layer, branchobj, '%s - updates for this layer branch have been disabled' % msg)
+
     try:
         lockfn = os.path.join(fetchdir, "layerindex.lock")
         lockfile = utils.lock_file(lockfn, options.timeout, logger)
@@ -442,7 +451,7 @@ def main():
                         if not topcommit:
                             errmsg = print_subdir_error(newbranch, layer.name, layerbranch.vcs_subdir, branchdesc)
                             if errmsg:
-                                record_layer_error(layer, branchobj, errmsg)
+                                disable_layerbranch_updates(layer, branchobj, layerbranch, errmsg)
                             if not (newbranch and layerbranch.vcs_subdir):
                                 record_layer_error(layer, branchobj, "Failed to get last revision for layer %s on branch %s" % (layer.name, branchdesc))
                             continue
@@ -462,11 +471,15 @@ def main():
                         if layerbranch.vcs_subdir and not os.path.exists(layerdir):
                             errmsg = print_subdir_error(newbranch, layer.name, layerbranch.vcs_subdir, branchdesc)
                             if errmsg:
-                                record_layer_error(layer, branchobj, errmsg)
+                                disable_layerbranch_updates(layer, branchobj, layerbranch, errmsg)
                             continue
 
                         if not os.path.exists(os.path.join(layerdir, 'conf/layer.conf')):
-                            record_layer_error(layer, branchobj, "conf/layer.conf not found for layer %s (branch %s) - is subdirectory set correctly?" % (layer.name, branch))
+                            errmsg = "conf/layer.conf not found for layer %s (branch %s) - is subdirectory set correctly?" % (layer.name, branch)
+                            if newbranch:
+                                record_layer_error(layer, branchobj, errmsg)
+                            else:
+                                disable_layerbranch_updates(layer, branchobj, layerbranch, errmsg)
                             continue
 
                     fd, initial_fn = tempfile.mkstemp(prefix='layerindex-initial-')
diff --git a/tests/test_update.py b/tests/test_update.py
index 3266d44..8cd3161 100644
--- a/tests/test_update.py
+++ b/tests/test_update.py
@@ -173,18 +173,19 @@ def test_initial_values_not_in_output(import_layer):
     assert 'BBFILE_COLLECTIONS = ' not in result.stdout
     assert 'Unable to find BBFILE_COLLECTIONS' not in result.stdout
 
-def set_layerbranch(subdir, last_rev):
+def set_layerbranch(subdir, last_rev, updates_enabled=True):
     # In a separate process, so that update.py sees the change: the tests run
     # in a transaction
     run_cmd('python3 manage.py shell -c "from layerindex.models import LayerBranch; '
             'LayerBranch.objects.filter(layer__name=\'meta-layerindex-test\').update('
-            'vcs_subdir=\'%s\', vcs_last_rev=\'%s\')"' % (subdir, last_rev), cwd=basepath)
+            'vcs_subdir=\'%s\', vcs_last_rev=\'%s\', updates_enabled=%s)"' % (subdir, last_rev, updates_enabled), cwd=basepath)
 
 def test_first_parse_error_recorded_against_layer(import_layer, repo, db_access_without_rollback_and_truncate):
     # [YOCTO #13490] an error that stops a layer being parsed is recorded
     # in the layer's update history, not only in the overall update log
     from layerindex.models import LayerBranch, LayerUpdate
     layerbranch = LayerBranch.objects.get(layer__name='meta-layerindex-test')
+    saved = (layerbranch.vcs_subdir, layerbranch.vcs_last_rev)
     set_layerbranch('meta-layerindex-test/recipes-example', '')
     try:
         result = subprocess.run("layerindex/update.py -l meta-layerindex-test --nofetch --nocheckout",
@@ -193,8 +194,12 @@ def test_first_parse_error_recorded_against_layer(import_layer, repo, db_access_
         layerupdate = LayerUpdate.objects.filter(layer=layerbranch.layer).order_by('-id').first()
         assert 'conf/layer.conf not found for layer meta-layerindex-test' in layerupdate.log, result.stdout
         assert layerupdate.errors == 1
+        # [YOCTO #12922] the layer has gone from the branch: stop updating it
+        assert 'updates for this layer branch have been disabled' in layerupdate.log
+        layerbranch.refresh_from_db()
+        assert not layerbranch.updates_enabled
     finally:
-        set_layerbranch(layerbranch.vcs_subdir, layerbranch.vcs_last_rev)
+        set_layerbranch(*saved)
 
 
 

base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
prerequisite-patch-id: 85be5c2fe68b937570c6e8be5a911e92864cdf63
prerequisite-patch-id: 85ea51619f1ba4ca8253c1df2d0f7689823f1d22
prerequisite-patch-id: e0e8ba9340973102abc551c2c349edbf518d6d48
-- 
2.56.0

