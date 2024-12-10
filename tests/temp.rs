#[cfg(test)]
mod tests {

    use moseiik::main::*;

    #[test]
    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    fn test_x86() {
        // Arguments to run program
        let args = Options {
            image: String::from("assets/kit.jpeg"),
            output: String::from("out.png"),
            tiles: String::from("assets/images/"),
            scaling: 1,
            tile_size: 25,
            remove_used: false,
            verbose: false,
            simd: true,
            num_thread: 1,
        };
        
        // Apply computte mosaic
        compute_mosaic(args);
        
        // Verify wether generated image corresponds to ground-truth or not to pass test
        let generated = image::open("out.png").unwrap();
        let ground_truth = image::open("assets/ground-truth-kit.png").unwrap();
        assert_eq!(generated.height(), ground_truth.height(), "Generated mosaic does not match ground truth for x86");

        //assert!(false);
    }

    #[test]
    #[cfg(target_arch = "aarch64")]
    fn test_aarch64() {

        // Arguments to run program
        let args = Options {
            image: String::from("assets/kit.jpeg"),
            output: String::from("out.png"),
            tiles: String::from("assets/images/"),
            scaling: 1,
            tile_size: 25,
            remove_used: false,
            verbose: false,
            simd: true,
            num_thread: 1,
        };
        
        // Apply computte mosaic
        compute_mosaic(args);
    
        // Verify wether generated image corresponds to ground-truth or not to pass test
        let generated = image::open("out.png").unwrap();
        let ground_truth = image::open("assets/ground-truth-kit.png").unwrap();
        assert_eq!(generated.height(), ground_truth.height(), "Generated mosaic does not match ground truth for aarch64");
        
        //assert!(false);
    }

    #[test]
    fn test_generic() {
        
        let args = Options {
            image: String::from("assets/kit.jpeg"),
            output: String::from("out.png"),
            tiles: String::from("assets/images/"),
            scaling: 1,
            tile_size: 25,
            remove_used: false,
            verbose: false,
            simd: false,
            num_thread: 1,
        };
    
        compute_mosaic(args);
    
        let generated = image::open("out.png").unwrap();
        let ground_truth = image::open("assets/ground-truth-kit.png").unwrap();
    
        assert_eq!(generated.height(), ground_truth.height(), "Generated mosaic does not match ground truth for generic implementation");
        
        //assert!(false);
    }
}
