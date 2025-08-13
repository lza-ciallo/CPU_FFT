import numpy as np

# 假设已有8点FFT函数（此处用numpy的fft替代示例）
def fft8(x):
    return np.fft.fft(x, 8)

def fft16(x):
    # 分解为偶/奇索引序列
    x_even = x[0:16:2]  # 偶数索引: 0,2,4,...,14
    x_odd  = x[1:16:2]  # 奇数索引: 1,3,5,...,15
    
    # 计算子FFT
    X_even = fft8(x_even)
    X_odd  = fft8(x_odd)
    
    # 初始化16点FFT结果
    X = np.zeros(16, dtype=complex)
    
    # 计算旋转因子 (k=0~7)
    N = 16
    k = np.arange(8)
    W = np.exp(-2j * np.pi * k / N)  # W_{16}^k
    
    # 合并前半部分 (k=0~7)
    X[:8] = X_even + W * X_odd
    
    # 合并后半部分 (k=8~15)
    X[8:] = X_even - W * X_odd  # 等价于 W_{16}^{k+8} = -W_{16}^k
    
    return X, W

# 测试示例
if __name__ == "__main__":
    # 生成16点测试信号（例如：1kHz正弦波 + 2kHz余弦波）
    fs = 8000  # 采样率
    t = np.arange(16) / fs
    x = 0.5 * np.sin(2 * np.pi * 1000 * t) + 0.8 * np.cos(2 * np.pi * 2000 * t)
    
    # 计算FFT
    X_custom, W_16 = fft16(x)          # 自定义16点FFT
    X_numpy  = np.fft.fft(x, 16) # NumPy标准结果
    
    # 验证误差
    error = np.max(np.abs(X_custom - X_numpy))
    print(f"与NumPy结果的最大误差: {error:.2e}")  # 应接近0

    # 额外
    # print(W_16)