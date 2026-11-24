Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15942.1795520515509562050
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Nov 2026 03:41:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wAHMWBydwVrP9QAAA--.4184S3;
	Tue, 24 Nov 2026 19:39:31 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowACXKWr5dwVrLcFAAA--.28459S2;
	Tue, 24 Nov 2026 19:41:45 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [meta-selinux][PATCH 0/4] Add selint and fix local refpolicy patches
Date: Tue, 24 Nov 2026 19:41:33 +0800
Message-ID: <20261124114137.2203106-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowACXKWr5dwVrLcFAAA--.28459S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYBCmsEQRspEgAAsB
X-CM-DELIVERINFO: =?B?hy96uqc9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOOlI2Du8d65gBCGhVRqdwZWdMjRwwccpwK8voxWX3qLFExsYkS5ozPkIGlTdXUVRawkZ
	H7KoxJKN/cFYrPU+4fTvq/Oy/3z4zCRlZrQ78qjqOdwcBdLKP92+hdhpApFEcQ==
X-Coremail-Antispam: 1Uk129KBj93XoW7KryDuF1UCryktryftFykXrc_yoW8XFW8pF
	43tFZ8JF1DXFyxZrn3C3Wj9FyftaykCa1q93srWr10y3yUZF1kAr48JryF9FWru347AwnF
	qr1ay3yfGay7AacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_Gw7v73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYa7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU81GQDUUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 11:42:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5505
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

Add selint (https://github.com/SELinuxProject/selint) which is
used to check if policies are written in a standard refpolicy way.

There are mainly two benefits:
1) People fixing refpolicy bugs can know in advance whether the codes
   conform to upstream refpolicy standard.
2) Local Yocto specific patches can now be linted in preparation for
   working closer with refpolicy upstream to add a new 'yocto' distro.

Chen Qi (4):
  selint: add recipe
  refpolicy: label start_getty as bin_t in corecommands.fc
  refpolicy: escape the dot in the /run/issue.d file context
  refpolicy: run selint over the policy sources

 recipes-security/refpolicy/files/selint.conf  | 16 ++++++++++
 ...ecommands-label-start_getty-as-bin_t.patch | 30 +++++++++++++++++++
 ...etty-add-file-context-to-start_getty.patch | 27 -----------------
 ...temd-add-rules-for-systemd-ssh-issue.patch |  2 +-
 .../refpolicy/refpolicy_common.inc            | 13 ++++++--
 recipes-security/selint/selint_git.bb         | 27 +++++++++++++++++
 6 files changed, 85 insertions(+), 30 deletions(-)
 create mode 100644 recipes-security/refpolicy/files/selint.conf
 create mode 100644 recipes-security/refpolicy/refpolicy/0023-fc-corecommands-label-start_getty-as-bin_t.patch
 delete mode 100644 recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
 create mode 100644 recipes-security/selint/selint_git.bb

-- 
2.43.0

