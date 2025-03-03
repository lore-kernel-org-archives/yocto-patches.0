Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BF3C282CD
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 15:59:56 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.56965.1741017587234582464
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 03 Mar 2025 07:59:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ThZ18Xj4;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43aac0390e8so29566005e9.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 03 Mar 2025 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741017586; x=1741622386; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/jX9O7LpLUIH/W9CK58aEHaYup65i8ISW+l5IT8Ohj8=;
        b=ThZ18Xj4XK/RunoFJ/jutWkHtEL8I5BRh/Di2j3VN/4daR5ehmviwfHYlayODjkHnU
         blO0PJ/U+0rNwC1uYxQASce4kVb6q8D67hyMsyn57m0yVb8z9a6whimfU6VD5+PkxGlf
         GM0fJnBHPbn0Q4imm/gKtjr2bpZtuD5KHnq2Vh+7hlcJAY5fVH/W8OPKOv3rLP4Sj0JC
         BKuJdBtmUQ7rijpNHGGyHDJVPLQmx/XSpe9pdj9oLR00qjhEPR2ABZlSLAeukLg1y64Q
         Tg7NCpWJqZMs8Qix7JhHB24H4mHi6dHT1OvcQcIwif44JIPYp+5kf8OzFu7EXqAWXKgD
         dEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017586; x=1741622386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jX9O7LpLUIH/W9CK58aEHaYup65i8ISW+l5IT8Ohj8=;
        b=uzlywtVaCVM33Nt9e4ZfbACn9nwzRxFAsAjjcWMPCK1p+0/lFVnTjTpljBnNslb+UI
         CfwQDK1DsYRA8Mx2BTv4vvW3im5sLgKzyLhcjKW9XdswQZ3HKlvj2KtWAKEjGmKf1Rfu
         i3fdi9BDSWDEOmXHiuxpTrxSm9Wr9mI0leDc+0LiZfxS/W/WHY26i3so6N7xORBSIHyD
         j/gtuM/inQ47JcuzO5KMfWPIJkWijAXrggf33r6aZ1GSmfqyWGoWoBFXsA5xTwau66hZ
         FR64rmdQvVUPWOvRCeH9PMub6nK5BtE6CFXmHf9vw25VIe1hqN0mVq+VUnvdYYwVvtcK
         ZZqw==
X-Gm-Message-State: AOJu0YzaLvhFMxJa0ODVt2uFz3QUCipZC9Ix5V78IrnMGlEGotDGwBJJ
	79iNGXaTSTclMnwoau91uW4wN/WN+YyFbbQIH4IDuRViB0mnFLPl8peXjuEi
X-Gm-Gg: ASbGncvjp1yK0RqJhQUQdlS8geDUmpeVHLyTwk7ejLaDGmRzY1qK2c+52E2IvucDk94
	/OPnFu5SGoSQu/XYCCyjyhbWYU2FbK62YN3KEdKOBBlzXyquRrHa7wOOw1A0vb0z9W4EAEmZ8+7
	v+VK8CmcWUKftXe13pdd6sFTUBbfVyM+LcxmOpVvK3asRf+0J9b09+4sARwCPR3UiUxJT6bEl6Y
	CS5R+tD237eRVZuO/RhOT9ppBlf3C0jLsENjCp9GxP2jilr1EkY1mGI03vXAICfUpmHiU+135N6
	yqTxurWcCJCJ5wv8d+Ymz3fWruIm5J4azgU5YQ9d2+HqKNg7Y5t9LeLYKrTBYimvwHrskNDAD0Y
	dnA==
X-Google-Smtp-Source: AGHT+IGiw5LYBvbnwYK5k9LPDq9hpGhnvk1wxJXT+r6facMIHJFFdJB8tgDOc35R2ZnDGcMf3CoETQ==
X-Received: by 2002:a05:600c:1384:b0:439:9192:f088 with SMTP id 5b1f17b1804b1-43ba66e6f80mr115710145e9.8.1741017585285;
        Mon, 03 Mar 2025 07:59:45 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47960b6sm15224776f8f.17.2025.03.03.07.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:59:44 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][master][PATCH] tensorflow.inc: add write permission to 2 more directories
Date: Mon,  3 Mar 2025 16:59:40 +0100
Message-ID: <20250303155940.2697475-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 03 Mar 2025 15:59:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1139

Missing write permission prevents the WORKDIR to be deleted, e.g. when recipe becames unreachable

Removing 41 recipes from the core2-64 sysroot: 100% |##########################################################################################################################################################################| Time: 0:00:21
Removing 35 recipes from the qemux86_64 sysroot: 100% |########################################################################################################################################################################| Time: 0:00:00
ERROR: Execution of event handler 'sstate_eventhandler_reachablestamps' failed                                                                                                                                                 | ETA:  0:00:07
Traceback (most recent call last):
  File "/OE/build/oe-core/openembedded-core/meta/classes-global/sstate.bbclass", line 1293, in sstate_eventhandler_reachablestamps
    bb.utils.remove(workdir, recurse = True)
    ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/OE/build/oe-core/bitbake/lib/bb/utils.py", line 751, in remove
    subprocess.check_call(cmd + ['rm', '-rf'] + glob.glob(path))
    ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.13/subprocess.py", line 421, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['rm', '-rf', '/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0']' returned non-zero exit status 1.

ERROR: Command execution failed: Traceback (most recent call last):
  File "/OE/build/oe-core/bitbake/lib/bb/command.py", line 123, in runAsyncCommand
    self.cooker.updateCache()
    ~~~~~~~~~~~~~~~~~~~~~~~^^
  File "/OE/build/oe-core/bitbake/lib/bb/cooker.py", line 1646, in updateCache
    bb.event.fire(event, self.databuilder.mcdata[mc])
    ~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 224, in fire
    fire_class_handlers(event, d)
    ~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
  File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 131, in fire_class_handlers
    execute_handler(name, handler, event, d)
    ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 102, in execute_handler
    ret = handler(event, d)
  File "/OE/build/oe-core/openembedded-core/meta/classes-global/sstate.bbclass", line 1293, in sstate_eventhandler_reachablestamps
    bb.utils.remove(workdir, recurse = True)
    ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/OE/build/oe-core/bitbake/lib/bb/utils.py", line 751, in remove
    subprocess.check_call(cmd + ['rm', '-rf'] + glob.glob(path))
    ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.13/subprocess.py", line 421, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['rm', '-rf', '/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0']' returned non-zero exit status 1.

Summary: There were 2 ERROR messages, returning a non-zero exit code.

OE qemux86-64@ /OE/build/oe-core $ find /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base/execroot
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base/execroot/org_tensorflow
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base/execroot/org_tensorflow/bazel-out
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base/execroot/org_tensorflow/bazel-out/k8-opt
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/python
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/python/schema_py_srcs_no_include_all
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/python/schema_py_srcs_no_include_all/schema_generated.py
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/python/schema_py_srcs_no_include_all/__init__.py
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools/pip_package
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools/pip_package/wheel_house
/OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools/pip_package/wheel_house/tensorflow-2.17.0-cp312-cp312-linux_x86_64.whl

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 recipes-framework/tensorflow/tensorflow.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-framework/tensorflow/tensorflow.inc
index 15464b9..36657a8 100644
--- a/recipes-framework/tensorflow/tensorflow.inc
+++ b/recipes-framework/tensorflow/tensorflow.inc
@@ -63,6 +63,9 @@ export TS_DL_DIR
 
 do_compile[network] = "1"
 
+# Missing write permission prevents the WORKDIR to be deleted, e.g. when recipe becames unreachable
 do_compile:append() {
     chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel-out/*/bin/tensorflow/lite/python/conversion_metadata_schema_py_srcs_no_include_all || true
+    chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel-out/*/bin/tensorflow/lite/python/schema_py_srcs_no_include_all || true
+    chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel-out/*/bin/tensorflow/tools/pip_package/wheel_house || true
 }
-- 
2.48.1


