#ifndef __DFS_SHARED__
#define __DFS_SHARED__

typedef struct dfs_superblock {
  // STUDENT: put superblock internals here
	int valid;
	int dfsBlockSize;   // File system block size
	int dfsMaxBlockNum; // File system max block num
	int inodeStartBlock; // Inode starting block num
	int maxInodeNum;    // Max inode num
	int fbvStartBlock;   // Free block vecter starting block num
} dfs_superblock;

#define DFS_BLOCKSIZE 1024  // Must be an integer multiple of the disk blocksize

typedef struct dfs_block {
  char data[DFS_BLOCKSIZE];
} dfs_block;

typedef struct dfs_inode {
  // STUDENT: put inode structure internals here
  // IMPORTANT: sizeof(dfs_inode) MUST return 96 in order to fit in enough
  // inodes in the filesystem (and to make your life easier).  To do this, 
  // adjust the maximumm length of the filename until the size of the overall inode 
  // is 96 bytes.
	int inuse;
	int size;      // File size
	int BTT[10];   // Block Translation Table
	int indirectTableBlock;
	char filename[44];
} dfs_inode;

#define DFS_MAX_FILESYSTEM_SIZE 0x1000000  // 16MB
#define DFS_FAIL -1
#define DFS_SUCCESS 1

#endif
