Return-Path: <wuxiaotian@loongson.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4ACC28B2E
	for <webhook@archiver.kernel.org>; Sun,  9 Mar 2025 06:00:58 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by mx.groups.io with SMTP id smtpd.web10.10949.1741500054774909610
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Mar 2025 22:00:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: loongson.cn, ip: 114.242.206.163, mailfrom: wuxiaotian@loongson.cn)
Received: from loongson.cn (unknown [192.168.100.1])
	by gateway (Coremail) with SMTP id _____8Bx63GTLs1nO5qPAA--.48154S3;
	Sun, 09 Mar 2025 14:00:52 +0800 (CST)
Received: from localhost.localdomain (unknown [192.168.100.1])
	by front1 (Coremail) with SMTP id qMiowMBxb8eSLs1nJr0_AA--.40372S2;
	Sun, 09 Mar 2025 14:00:50 +0800 (CST)
From: Xiaotian Wu <wuxiaotian@loongson.cn>
To: yocto-patches@lists.yoctoproject.org
Cc: Xiaotian Wu <wuxiaotian@loongson.cn>
Subject: [pseudo] [PATCH 0/3] Porting pseudo to LoongArch
Date: Sun,  9 Mar 2025 14:00:36 +0800
Message-ID: <20250309060039.454124-1-wuxiaotian@loongson.cn>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8eSLs1nJr0_AA--.40372S2
X-CM-SenderInfo: 5zx0xtprwlt0o6or00hjvr0hdfq/1tbiAgEQCGfMz2ABsQAJsm
X-Coremail-Antispam: 1Uk129KBj9xXoWruF45JFy7XFWrKr1rZw18JFc_yoWkCFX_uw
	47GFWkA3WDXFWDJa4Dtw1rXryDtr48tF1rKF9Fk3Zruw1UXFWUX3Zaqw18X3WUtrW5Xr1x
	KF4DAw1rKr1UtosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 09 Mar 2025 06:00:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1166

Add support for LoongArch, and make test passed.

$ uname -m
loongarch64
$ make test
./run_tests.sh -v
test-acl: Passed.
test-chroot: Passed.
test-chroot-symlink: Passed.
test-cp-setuid: Passed.
test-dir-move: Passed.
test-env_i: Passed.
test-execl: Passed.
test-fcntl: Passed.
test-fstat: Passed.
test-openat: Passed.
test-open-symlinks: Passed.
test-pseudo_disable-fork-env_i: Passed.
test-pseudo_disable-fork: Passed.
test-pseudo_unload-fork-env_i: Passed.
test-pseudo_unload-fork: Passed.
test-reexec-chroot: Passed.
test-relative-from-root: Passed.
test-rename-fstat: Passed.
couldn't allocate absolute path for 'null'.
test-statx: Passed.
test-tclsh-fork: Passed.
test-umask: Passed.
test-xattr: Passed.
22/22 test(s) passed.


Xiaotian Wu (3):
  pseudo_wrappers.c: Add support for LoongArch64
  Makefile.in: Use ARCH_FLAGS instead of -m32 and -m64
  configure: Add support for LoongArch

 Makefile.in       |  4 +--
 configure         | 11 +++++++-
 pseudo_wrappers.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 3 deletions(-)

-- 
2.48.1


