Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2004.1793669451375932653
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Nov 2026 17:30:52 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wD34NbYOOlqZrgBAA--.4469S3;
	Tue, 03 Nov 2026 09:28:56 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABH2Gh_OOlqOAgrAA--.28414S3;
	Tue, 03 Nov 2026 09:27:31 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org,
	richard.purdie@linuxfoundation.org,
	mark.hatle@kernel.crashing.org
Cc: chen_q07@163.com
Subject: [pseudo][PATCH V2 2/2] pseudo_client.h: remove dangling pseudo_client_fdpath declaration
Date: Tue,  3 Nov 2026 09:30:28 +0800
Message-ID: <20261103013028.3295799-2-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103013028.3295799-1-chenqi_hycx@cetc.com.cn>
References: <20261103013028.3295799-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABH2Gh_OOlqOAgrAA--.28414S3
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYACmrok1IH-QAAs0
X-CM-DELIVERINFO: =?B?3NRMy6c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOChY5TDxb8V/J8ZyqMAlpTIh6JzZxzxBgEp5TljL6EUpJzDyR/UziSnv3uDfcmcp7fMv
	MBWYZdIILHtBsGrKM+OUA8NEZv24jrx7kQenjGgKVcDVIOBKB5cWaKDcIz1qBQ==
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw4rtF47Cw4rJFyxKry8JFc_yoWxuwb_Gw
	43JF1IgrW5tFnY93ZI9a4Yqr4Yqay7JrWavwnxXr42y34vgr1DCr1kGryxJF4qqrWUXF1x
	C39F93Zxtwn7XosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjg05I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVWkYxn0WfASr-VF
	AUDa7-sFnT9fnUUIcSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I
	8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
	6r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUAVWUtwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
	43ZEXa7IU1DUUUUUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Nov 2026 01:31:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5215
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

There's no definition and there's no user. Delete it.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 pseudo_client.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/pseudo_client.h b/pseudo_client.h
index b3f9f49..19f3901 100644
--- a/pseudo_client.h
+++ b/pseudo_client.h
@@ -25,7 +25,6 @@ extern void pseudo_antimagic(void);
 extern void pseudo_magic(void);
 extern void pseudo_client_touchuid(void);
 extern void pseudo_client_touchgid(void);
-extern char *pseudo_client_fdpath(int fd);
 extern int pseudo_client_shutdown(int);
 extern int pseudo_fd(int fd, int how);
 #define MOVE_FD	0
-- 
2.43.0

