Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4397.1794623207737837535
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 18:26:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=nJ0wrK0K;
 spf=pass (domain: gmail.com, ip: 209.85.215.176, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso775757a12.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 18:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794623207; x=1795228007; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lxpxJhmrTPKiUsWn+1bZKE9C8zKMHvbWmVyClj+3v6M=;
        b=nJ0wrK0KhKGW+/XNQcukuuRadLDJXxLdup9/hU0goQqbbsbaoaLgncrvo+ZQ1QtUsk
         oDhFMdWyv6IAH9ghxyanPmbFzaoDpks5sk+DBLBlM0qAC656H2NpQzTtKhPYF6v19xmz
         zpS4M4NHhPkRh8JY1LwYp+dUK1kV0FEGy4j3QbhP+/ktg/b5XK6p23v+DSWOMAfMscTC
         ZGmp3uDVh6UCkpaTV1Qz6oELela5WwbG1qIqafdvi/LVIIytSUHhqdfVGiaflSk2uwV0
         Rp9cE49MJGG69DxIhdMiXEnWhCd8cbW4Ksc384wx+wR5SE7T7vW+AoNBYs4o6XBUPel+
         KGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794623207; x=1795228007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lxpxJhmrTPKiUsWn+1bZKE9C8zKMHvbWmVyClj+3v6M=;
        b=FW9kjstwUdZQoJI9s6wX5EJAqILD0Wia1tbCXrtPe7dyhU/8AxL/OoqaFiuHTZaGwg
         9OnpD7jIAhRDN14YIqWjrvxG38SbVT44KN1EfDrz6o6TU33ABh/2R68zbrM3xTayH/UO
         IflU3PtleJnEVjGyw98Fq1tL0ejPYri0oJfDKDtCYVfXzs/iQtx58py12wnFv7XEzgDR
         wts4QXSIySqqJwERcE5G/peF1Y+gO33SzHPiM1qY8bwU6P6OcBSPIyF4scTJs3Ct9iMQ
         0AVCY40SgDEimBUaO1Ngsr3dGtyit/Y2K08bWWNWsGCWPBeu26uyML3C65yhrIk0LcMV
         G/ww==
X-Gm-Message-State: APuU4Z/GHWyAdWaUpnHO9DSqE5OczYF8CKJDhlaKvJfN9a+C/19mU6ej
	poJbg87kcqGT6wKovREF3sHkq64/mIeMO80GIMA4CPyjuLfoBmU4C8GKINX93iK8
X-Gm-Gg: AYBFou3YKTs/RUpKUZkfqNSVdMOLrFZ7whfRXlDGBJtxFkLXP3T864CDKAeUeP67i5D
	jtu6uVOWuaACF4yu3pmCrW5L4XBwkpgoslJGQHY6V8dlqTNCEU/X5lxhrnLkERfaKmI5pbb/Hex
	utTKu3l60m8shKet6BE+CmZgnC4OgS3cyPhIXa/cKtDPKekrbtyr5trIvGNS1l5qeLnY8ypTp6L
	Eln7+Na5HH06obNR4YuwDJnULHt9JnNdSDSR+uciR2bF5WAQlEj99IjAh4BOIY07Sl9tegcDYfJ
	OlMQ6318/8NKnEIAEsl3LU+PnRy5Gh8ZvNKqW0VSqHSknw3iE4zD3sMZBgiHnd1xKNJFAzvM/3P
	rKWN04Yb7N5wRcU+G0V66BW3233PpBxrSDjgMwubNZ1ef4I4loZ6NGOFt/T3XOvhjz7xKmjMb/k
	xKbFLMZCwn9T+G1WtJ8/VmqCdDeUGy3DCsI5awdtg/lvpv80eRFIdzWi3oFetIdpzLVHnfyfuWZ
	Ud5SQmnQrLDqPwfe1PANhpUcbemREKNtwQrk1erah9AlVfFyf8qUw/f9dNpCLR8R2Gj+Sg7rKwE
	8Ab3HTqbMr5R0fHp/fh08OBf9Hz4dHqYqYzHtFANUlpqVk43yYPAjNkNOc+iabbGaudOXqFQIux
	j94IBqBo=
X-Received: by 2002:a17:90b:1650:b0:3ab:3437:554f with SMTP id 98e67ed59e1d1-3b1b0a0db3bmr4354767a91.29.1794623206866;
        Fri, 13 Nov 2026 18:26:46 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec622b6sm7433636a91.11.2026.11.13.18.26.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 18:26:45 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/3] update: record errors in a layer's first parse against the layer
Date: Fri, 13 Nov 2026 18:26:36 -0800
Message-ID: <20261114022637.60789-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114022637.60789-1-tim.orling@konsulko.com>
References: <20261114022637.60789-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 02:26:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5358
Content-Type: text/plain; charset="utf-8"

When update.py could not parse a layer's conf/layer.conf in its first
pass (fetch failed, subdirectory or conf/layer.conf missing, no
BBFILE_COLLECTIONS, LAYERDEPENDS not satisfied), it only logged the
error in the overall update log, so nothing showed in the layer's own
update history. Record these as layer updates with the error, as is
already done when update_layer.py itself fails.

[YOCTO #13490]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/update.py | 40 +++++++++++++++++++++++++++++++---------
 tests/test_update.py | 23 +++++++++++++++++++++++
 2 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/layerindex/update.py b/layerindex/update.py
index ccf44a3..dd794dd 100755
--- a/layerindex/update.py
+++ b/layerindex/update.py
@@ -124,10 +124,12 @@ def print_subdir_error(newbranch, layername, vcs_subdir, branchdesc):
     # This will error out if the directory is completely invalid or had never existed at this point
     # If it previously existed but has since been deleted, you will get the revision where it was
     # deleted - so we need to handle that case separately later
+    # Returns the error, if it is one, for the caller to record
     if newbranch:
         logger.info("Skipping update of layer %s for branch %s - subdirectory %s does not exist on this branch" % (layername, branchdesc, vcs_subdir))
     elif vcs_subdir:
-        logger.error("Subdirectory for layer %s does not exist on branch %s - if this is legitimate, the layer branch record should be deleted" % (layername, branchdesc))
+        return "Subdirectory for layer %s does not exist on branch %s - if this is legitimate, the layer branch record should be deleted" % (layername, branchdesc)
+    return None
 
 def extract_value(valuename, output):
     res = re.search("^%s = \"(.*)\"" % valuename, output, re.M)
@@ -277,6 +279,18 @@ def main():
         update.reload = False
     if not options.dryrun:
         update.save()
+
+    def record_layer_error(layer, branchobj, msg, log=True):
+        """Record an error that stops a layer being updated against the layer,
+        so that it shows in its update history, not only in this update's log"""
+        if log:
+            logger.error(msg)
+        layerupdate = LayerUpdate(update=update, layer=layer, branch=branchobj,
+                                  started=datetime.now(), finished=datetime.now(),
+                                  log='ERROR: %s' % msg, retcode=1)
+        if not options.dryrun:
+            layerupdate.save()
+
     try:
         lockfn = os.path.join(fetchdir, "layerindex.lock")
         lockfile = utils.lock_file(lockfn, options.timeout, logger)
@@ -363,7 +377,8 @@ def main():
 
                 for layer in layerquery:
                     if layer.vcs_url in failedrepos:
-                        logger.info("Skipping update of layer %s - fetch failed" % layer.name)
+                        # fetch_repo() has already logged the error
+                        record_layer_error(layer, branchobj, "Fetch of layer %s failed: %s" % (layer.name, failedrepos[layer.vcs_url]), log=False)
                         continue
 
                     layerbranch = layer.get_layerbranch(branch)
@@ -400,7 +415,7 @@ def main():
                     repodir = os.path.join(fetchdir, urldir)
                     repo = git.Repo(repodir)
                     if repo.bare:
-                        logger.error('Repository %s is bare, not supported' % repodir)
+                        record_layer_error(layer, branchobj, 'Repository %s is bare, not supported' % repodir)
                         continue
                     try:
                         # Allow stable branches to be created if actual_branch exists
@@ -425,9 +440,11 @@ def main():
                         # A bit odd to do it this way but apparently there's no other way in the GitPython API
                         topcommit = next(repo.iter_commits('origin/%s' % branchname, paths=layerbranch.vcs_subdir), None)
                         if not topcommit:
-                            print_subdir_error(newbranch, layer.name, layerbranch.vcs_subdir, branchdesc)
+                            errmsg = print_subdir_error(newbranch, layer.name, layerbranch.vcs_subdir, branchdesc)
+                            if errmsg:
+                                record_layer_error(layer, branchobj, errmsg)
                             if not (newbranch and layerbranch.vcs_subdir):
-                                logger.error("Failed to get last revision for layer %s on branch %s" % (layer.name, branchdesc))
+                                record_layer_error(layer, branchobj, "Failed to get last revision for layer %s on branch %s" % (layer.name, branchdesc))
                             continue
 
                     if layerbranch.vcs_last_rev == topcommit.hexsha and not update.reload:
@@ -443,11 +460,13 @@ def main():
                                 utils.checkout_layer_branch(layerbranch, repodir, actual_branch=options.actual_branch, logger=logger)
                         layerdir = os.path.join(repodir, layerbranch.vcs_subdir)
                         if layerbranch.vcs_subdir and not os.path.exists(layerdir):
-                            print_subdir_error(newbranch, layer.name, layerbranch.vcs_subdir, branchdesc)
+                            errmsg = print_subdir_error(newbranch, layer.name, layerbranch.vcs_subdir, branchdesc)
+                            if errmsg:
+                                record_layer_error(layer, branchobj, errmsg)
                             continue
 
                         if not os.path.exists(os.path.join(layerdir, 'conf/layer.conf')):
-                            logger.error("conf/layer.conf not found for layer %s (branch %s) - is subdirectory set correctly?" % (layer.name, branch))
+                            record_layer_error(layer, branchobj, "conf/layer.conf not found for layer %s (branch %s) - is subdirectory set correctly?" % (layer.name, branch))
                             continue
 
                     fd, initial_fn = tempfile.mkstemp(prefix='layerindex-initial-')
@@ -479,7 +498,7 @@ def main():
 
                     col = extract_value('BBFILE_COLLECTIONS', initial_values)
                     if not col:
-                        logger.error('Unable to find BBFILE_COLLECTIONS value in initial values')
+                        record_layer_error(layer, branchobj, 'Unable to find BBFILE_COLLECTIONS value for layer %s - is it set in conf/layer.conf?' % layer.name)
                         # Assume (perhaps naively) that it's an error specific to the layer
                         continue
                     ver = extract_value('LAYERVERSION', initial_values)
@@ -548,7 +567,10 @@ def main():
                         for layer, value in deps_dict_all.items():
                             logger.warn('%s: LAYERDEPENDS: %s LAYERRECOMMENDS: %s' % (layer.name, value['deps'], value['recs']))
                             if value['deps']:
-                                failed_layers[branch].append('%s: Failed to add since LAYERDEPENDS [%s ...] is not satisfied' % (layer.name, next(iter(value['deps']))))
+                                failed_msg = '%s: Failed to add since LAYERDEPENDS [%s ...] is not satisfied' % (layer.name, next(iter(value['deps'])))
+                                failed_layers[branch].append(failed_msg)
+                                # Reported with the other issues at the end
+                                record_layer_error(layer, branchobj, failed_msg, log=False)
                             else:
                                 # Should never come here
                                 logger.error("Unexpected errors when sorting layers")
diff --git a/tests/test_update.py b/tests/test_update.py
index 1e1db0d..3266d44 100644
--- a/tests/test_update.py
+++ b/tests/test_update.py
@@ -173,6 +173,29 @@ def test_initial_values_not_in_output(import_layer):
     assert 'BBFILE_COLLECTIONS = ' not in result.stdout
     assert 'Unable to find BBFILE_COLLECTIONS' not in result.stdout
 
+def set_layerbranch(subdir, last_rev):
+    # In a separate process, so that update.py sees the change: the tests run
+    # in a transaction
+    run_cmd('python3 manage.py shell -c "from layerindex.models import LayerBranch; '
+            'LayerBranch.objects.filter(layer__name=\'meta-layerindex-test\').update('
+            'vcs_subdir=\'%s\', vcs_last_rev=\'%s\')"' % (subdir, last_rev), cwd=basepath)
+
+def test_first_parse_error_recorded_against_layer(import_layer, repo, db_access_without_rollback_and_truncate):
+    # [YOCTO #13490] an error that stops a layer being parsed is recorded
+    # in the layer's update history, not only in the overall update log
+    from layerindex.models import LayerBranch, LayerUpdate
+    layerbranch = LayerBranch.objects.get(layer__name='meta-layerindex-test')
+    set_layerbranch('meta-layerindex-test/recipes-example', '')
+    try:
+        result = subprocess.run("layerindex/update.py -l meta-layerindex-test --nofetch --nocheckout",
+                                shell=True, cwd=basepath, stdout=subprocess.PIPE,
+                                stderr=subprocess.STDOUT, text=True)
+        layerupdate = LayerUpdate.objects.filter(layer=layerbranch.layer).order_by('-id').first()
+        assert 'conf/layer.conf not found for layer meta-layerindex-test' in layerupdate.log, result.stdout
+        assert layerupdate.errors == 1
+    finally:
+        set_layerbranch(layerbranch.vcs_subdir, layerbranch.vcs_last_rev)
+
 
 
 
-- 
2.56.0

