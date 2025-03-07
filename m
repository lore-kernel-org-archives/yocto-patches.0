Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F08C19F32
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 07:56:27 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.6407.1741334179652290201
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Mar 2025 23:56:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=c8A/N8cj;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bc30adad5so9260345e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 06 Mar 2025 23:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741334178; x=1741938978; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+AphItEo80hxtuJNtn3XOdo/H/U5yfqrdZcuHpnwBw=;
        b=c8A/N8cj6Jy0116FLEqAW3I1cUcD/iP2awbv732/9RbQvFmdU7GR01Bw28RDBMAvFL
         V3aPFfMe0gRwmcRtg7cGvWhZIYFXhHSNUjDV/dOqv4B8onZ+7q9+tOnda00G7HkosXk+
         6TR5lzJG3d6Icm2p0kIEaCWj/tnXwSpjaaF4HTPf100BtJVfuHoxJC/84UETYvhJTui2
         xtn0lb7WFfrrFBckHJ3nCprN9cknI2cHpPQkXlpLZmPDuwh9TVwZE0BlEllBst7M113S
         AlO9XbthkWBYLS2yLA+0nndCeDMbYRg7ATkZGiuG6nyHmArKOVeIHr8pRcra/lxeg1dl
         yaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741334178; x=1741938978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+AphItEo80hxtuJNtn3XOdo/H/U5yfqrdZcuHpnwBw=;
        b=fdLohrei5Gt8/hP8yYbzNzMcsuxJuaC0mIS02auFKq7Jt0zamlCPVgChkkTYiFKCuw
         zADvS2A5zWQQJrnkJtX0Rwpz04cQp4mf7yrg16k8F0z9GrocKEr2wwmujhthkRa2fVYj
         JgHdkTqhOXWRPa6WjOoLFfh00IE1uu1crCK4PhK6U5TBZnbb33LNjwVsvJBDWQCrUmB5
         uvXXgIKkCF+0DODKWrs3ZjwEa8+lju5NAG7BS2aYp/p5zwGQ6kHXcYRRFpKz96df0mzt
         UW/d/8kTDVGsu0Rr2oFfwpLSDASyGpSNKYur2/SomdSXTflxsREuOCTejrZeHxZJzU6K
         +7kQ==
X-Gm-Message-State: AOJu0Yy7yZdDt+Smw8HBt+YfHp/HJGYys7Itg9T3Xf1igLPT6sXg4oOi
	FL8ZfLQHE7FPP+c4EdGaLIgj/GNEtLKLwaNYOMlBQAscH9ajdH+jyxhqTA==
X-Gm-Gg: ASbGncvF3XJpnoh8pFKSnBJvVvHrQ9wXVQpa2DdbM5z13fT9q6DPlT3KPlKECn9kQvR
	CdBf/hJTrlrcBolvSZi8Z2YmFXu8S1DHUM8AhEVS7wx4iq+xprWX08hnL2EcnyHC6gsUFoXjxfS
	qg/eordL8Pw+LaM10B7XCcrCQuC4S8+EuSxyJP7oRtKGCSmThWjomaNUFbIz1fmw1FeIG2xaFxy
	pcyi3cfBJB7Lg/bAY6M2i5cEZGrFFmJFHvkSmFQadIG1BzJO6YeuCx4uJVnhRtIotxHhT8OtPh3
	qg70rF6gTe075iazbf+Fdfuz0f0OjtFRkeKpV9uiMJ3TiZw=
X-Google-Smtp-Source: AGHT+IF6qrMC9uob7HMzki72Zg0D4kXvsyXwyjnGIci/kmja5xxzP7cX7i7R0IoKNwxvLhsCz9ZT8w==
X-Received: by 2002:a05:600c:314f:b0:439:9a5b:87d4 with SMTP id 5b1f17b1804b1-43c5a60e966mr15120165e9.13.1741334177747;
        Thu, 06 Mar 2025 23:56:17 -0800 (PST)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bdd948cd0sm42315095e9.38.2025.03.06.23.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 23:56:17 -0800 (PST)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][scarthgap][PATCH] tensorflow.inc: add write permission to 2 more directories
Date: Fri,  7 Mar 2025 08:56:10 +0100
Message-ID: <20250307075610.2235124-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 07 Mar 2025 07:56:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1163

From: Martin Jansa <martin.jansa@gmail.com>

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
index e48808c..83e2d1a 100644
--- a/recipes-framework/tensorflow/tensorflow.inc
+++ b/recipes-framework/tensorflow/tensorflow.inc
@@ -61,6 +61,9 @@ export TS_DL_DIR
 
 do_compile[network] = "1"
 
+# Missing write permission prevents the WORKDIR to be deleted, e.g. when recipe becames unreachable
 do_compile:append() {
     chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel-out/*/bin/tensorflow/lite/python/conversion_metadata_schema_py_srcs_no_include_all || true
+    chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel-out/*/bin/tensorflow/lite/python/schema_py_srcs_no_include_all || true
+    chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel-out/*/bin/tensorflow/tools/pip_package/wheel_house || true
 }

