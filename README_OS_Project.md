# 🧠 Custom Operating System in C (Portfolio + Deep Learning Project)

---

## 🎯 Project Objective

Build a custom Linux-like operating system entirely from scratch using **C and x86 Assembly**, targeting x86_64 architecture, and running initially inside **QEMU** with software emulation (no hardware virtualization support required).

This project is a personal deep dive into systems programming and computer networking with the goal of:
- Gaining **real-world mastery of low-level computing concepts** (memory, interrupts, file systems, schedulers, etc.)
- Becoming a **standout candidate** in technical interviews by showcasing rare expertise
- Creating a **highly unique portfolio project** that reflects deep curiosity and engineering skill

---

## 🧑‍💻 Personal Development Setup

| Component          | Description                                               |
|-------------------|-----------------------------------------------------------|
| Dev Machine        | Mac Mini (M4, ARM-based) — writing and remote controlling |
| Target Machine     | Lenovo ThinkCentre (i5, 8GB RAM, 512GB SSD, x86_64)       |
| Access Strategy    | SSH into ThinkCentre from Mac (via subnet IP)             |
| Editor             | VS Code with Remote SSH or terminal-based dev             |
| Compiler Toolchain | `i686-elf-gcc`, `nasm`, `make`, `qemu-system-x86_64`      |
| Virtualization     | ✅ QEMU software emulation (❌ No hardware VT-x/KVM)       |

---

## 🔩 What I'm Building

### Core Components (MVP OS)
- 🧼 Custom bootloader using GRUB and Assembly
- ⚙️ Kernel in C with direct VGA text output
- 🧠 Manual memory management:
  - Physical memory allocator
  - Virtual memory via paging (4KB pages, page tables, CR3/CR0)
- ⌨️ Interrupt handling (IDT, IRQs, timer, keyboard)
- 💬 Basic shell (input loop + built-in commands)
- 🔁 Round-robin scheduler (preemptive or cooperative)
- 💾 Filesystem support (EXT2 or FAT32 loader)
- 🚀 Bootable ISO for QEMU and USB deployment

### Stretch Goals
- 🌐 Simple TCP/IP stack (ARP, ICMP, UDP echo server)
- 🧩 User/program loading with ELF support
- 🔐 User/kernel mode separation
- 🧱 Syscalls & process sandboxing

---

## 🗂️ Project Structure

```bash
/os-project
├── boot/           # Bootloader code (Assembly)
├── kernel/         # Kernel code (C)
├── include/        # Header files
├── build/          # Compiled binaries + ISOs
├── devlog/         # Learning logs (daily/topic-wise)
├── scripts/        # Helper scripts (e.g., run QEMU, create logs)
├── Makefile        # Full build + run setup
├── README.md       # This file
```

---

## 📆 Learning Timeline (1–2 hours/day, ~3 months total)

| Phase | Focus Area                               | Est. Duration |
|-------|-------------------------------------------|----------------|
| 0     | Toolchain setup, project bootstrapping    | 1 week         |
| 1     | Bootloader + kernel basics                | 1 week         |
| 2     | VGA text mode, interrupts, IRQs           | 2 weeks        |
| 3     | Memory management + paging                | 2 weeks        |
| 4     | Shell, keyboard input, simple programs    | 2 weeks        |
| 5     | Task scheduler + context switching        | 2 weeks        |
| 6     | (Optional) Network stack + driver         | 2 weeks        |
| 7     | Polish, docs, USB boot, performance test  | 2 weeks        |

🧠 Total estimated commitment: **~100–150 hours**

---

## 📘 DevLogs: Your Learning Trail

All technical learnings, debugging stories, and discoveries are recorded in `/devlog/`.  
Each entry includes:
- What I learned today (concepts, registers, specs)
- What I built
- Bugs I faced and how I fixed them
- Interesting code snippets
- What's next

### ✅ DevLog Template

```markdown
# 🗓️ DevLog - Day 7: Basic Paging Setup

## 🧠 What I Learned
- Paging splits memory into 4KB pages
- Page tables must be aligned
- CR3 = page directory, CR0 bit 31 = enable paging

## ⚙️ What I Built
- Page directory and page table (first 4MB)
- Mapped identity addresses
- Enabled paging using CR0

## 🐛 Bugs I Fixed
- Triple fault on boot (forgot "present" bit)
- Page table not 4KB aligned → QEMU crash
- Used QEMU's `-d int -no-reboot` to debug

## 💬 Code Snippet

```c
page_directory[0] = ((uint32_t) page_table) | 3;
asm volatile("mov %0, %%cr3" :: "r"(page_directory));
...
```

## 🚀 Next Steps
- Abstract page allocation
- Implement `kmalloc()` and `kfree()`
```

---

## 🚀 Deployment Targets

- 👨‍💻 Primary Testing: QEMU on ThinkCentre (via SSH)
- 🔥 Final Test: Bootable USB on ThinkCentre
  - GRUB-based ISO image
  - Test VGA output, keyboard, and paging on real hardware

---

## 💼 Why This Project Matters (Interview Strategy)

This project is built not just to learn — but to **stand out in interviews** and show you're "cracked" (deeply knowledgeable) as a systems-level dev.

You'll be able to say:
> "I built a working OS kernel in C — wrote my own memory manager, paging system, and multitasking scheduler. Booted on real hardware. Here's the repo."

### What It Shows:
- Mastery of low-level programming and hardware interface
- Deep understanding of how modern OSes and CPUs work
- Initiative, curiosity, and ability to tackle hard problems
- Rare, standout portfolio project no bootcamp or course gives

### Resume Sample Entry:

```
🧠 Custom Operating System (C + Assembly)
- Designed and built a 32-bit OS kernel with manual paging, interrupt handling, task scheduling, and shell interface.
- Implemented from scratch using i686 GCC cross-compiler, GRUB bootloader, and QEMU for x86_64.
- Emphasized core systems concepts: memory layout, protected mode, IDT, CR3/CR0, virtual memory, and page fault handling.
```

---

## 📚 Resources Used

- [OSDev Wiki](https://wiki.osdev.org/Main_Page)
- [JamesM Kernel Dev](http://www.jamesmolloy.co.uk/tutorial_html/)
- [Operating Systems: From 0 to 1](https://github.com/tuhdo/os01)
- [PonchoDevs OS YouTube Series](https://www.youtube.com/playlist?list=PLkMS6Gg0yLSKMsZJJ2Vt1LUfwn-7uYZQz)
- [Low Level Academy](https://www.youtube.com/@LowLevelAcademy)

---

## 🏁 Let's Go

This repo will evolve over time. The logs, code, and README will reflect every major learning and milestone hit during the journey.

If you're reading this or following along — let's build something most devs are too scared to even try. 🧠🔥
